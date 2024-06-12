import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show TextEditingController, immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turning_point/bloc/contractor/contractor_bloc.dart';
import 'package:turning_point/bloc/points/points_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/model/contractor_model.dart';
import 'package:turning_point/preferences/app_preferences.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/Exception/api_exception.dart';
import 'package:turning_point/service/auth/auth_exceptions.dart';
import 'package:turning_point/service/auth/auth_provider.dart';
import 'package:turning_point/service/auth/firebase_auth_provider.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(CustomAuthProvider provider) : super(InitialState()) {
//====================Initialize====================//
    on<AuthInitializeEvent>((event, emit) async {
      try {
        emit(
          AuthLoadingState(
            phone: state.phone,
            businessName: state.businessName,
            contractor: state.contractor,
            refCode: state.refCode,
          ),
        );
        await provider.initialize();
        final userFromPreference = UserRepository.getUserFromPreference();
        if (userFromPreference != null) {
          if (provider.currentUser == null) {
            await provider.signIn();
          }
          final notificationType =
              AppPreferences.getValueShared('notification_type');
          await DefaultCacheManager().emptyCache();

          AppPreferences.addSharedPreference(
            key: 'notification_type',
            value: notificationType,
          );

          profileBloc.add(ProfileLoadEvent(avoidGettingFromPreference: true));
          return emit(DirectSignedInState());
        } else {
          return emit(InitialState());
        }
      } on ProfileInactiveException {
        return emit(ProfileInactiveState());
      } catch (e) {
        return emit(InitialState());
      }
    });

//====================GoogleSignInEvent====================//
    on<GoogleSignInEvent>(
      (event, emit) async {
        emit(
          AuthLoadingState(
            phone: state.phone,
            businessName: state.businessName,
            contractor: state.contractor,
            refCode: state.refCode,
          ),
        );
        try {
          await provider.signOut();
          final token = await provider.signIn();
          final fcmToken = await provider.getFcmToken();
          final status = await UserRepository.userSignIn(
            token: token,
            fcmToken: fcmToken!,
          );
          if (status) {
            await UserRepository.getUserById(avoidGettingFromPreference: true);
            profileBloc.add(ProfileLoadEvent(avoidGettingFromPreference: true));
            pointsBloc
                .add(PointsLoadEvent(avoidGettingUserFromPreference: true));
            return emit(SignedInState());
          } else {
            return emit(WhoIsSigningState());
          }
        } on FirebaseAuthException catch (_) {
          return emit(
            AuthErrorState(
              message: 'Something went wrong while connecting to the Firebase.',
              phone: state.phone,
              businessName: state.businessName,
              contractor: state.contractor,
              refCode: state.refCode,
            ),
          );
        } on ProfileInactiveException {
          return emit(ProfileInactiveState());
        } on CouldNotSignInUserAuthException {
          return emit(
            AuthErrorState(
              message: 'Something went wrong while connecting to the Server.',
              phone: state.phone,
              businessName: state.businessName,
              contractor: state.contractor,
              refCode: state.refCode,
            ),
          );
        } catch (e) {
          return emit(
            AuthErrorState(
              message: 'Something went wrong while connecting to the Server.',
              phone: state.phone,
              businessName: state.businessName,
              contractor: state.contractor,
              refCode: state.refCode,
            ),
          );
        }
      },
    );

//====================Sign Up Event====================//
    on<SignUpEvent>(
      (event, emit) async {
        emit(
          AuthLoadingState(
            phone: state.phone,
            businessName: state.businessName,
            contractor: state.contractor,
            refCode: state.refCode,
          ),
        );
        try {
          //avoid all the checks if it's already done
          if (event.avoidChecks != true) {
            final phoneExists =
                await UserRepository.checkPhoneNumber(event.phone);
            if (phoneExists) {
              return emit(PhoneNumberExistsState());
            } else {
              if (event.refCode != null && event.refCode!.isNotEmpty) {
                final isRefCodeValid =
                    await UserRepository.checkRefCode(event.refCode!);
                if (!isRefCodeValid) {
                  return emit(InvalidReferralCodeState());
                }
              }
            }

            if (contractorBloc.state.contractorNotListed == true) {
              return emit(AddContractorDetailsState());
            }
          }

          emit(
            OtpVerificationNeededState(
              phone: event.phone,
              businessName: event.businessName,
              contractor: event.contractor,
              refCode: event.refCode,
            ),
          );
          await provider.sendPhoneVerification(
            phone: event.phone,
            otpController: event.otpController,
          );
        } on FirebaseAuthException catch (e) {
          return emit(SignUpState(exception: e));
        } catch (_) {
          return emit(
            AuthErrorState(
              message:
                  'Something went wrong while accessing\nthe server. Please try after sometime',
              phone: state.phone,
              businessName: state.businessName,
              contractor: state.contractor,
              refCode: state.refCode,
            ),
          );
        }
      },
    );

//====================Verify Otp Event====================//
    on<VerifyOtpEvent>((event, emit) async {
      emit(
        AuthLoadingState(
          phone: state.phone,
          businessName: state.businessName,
          contractor: state.contractor,
          refCode: state.refCode,
        ),
      );
      try {
        final token = await provider.verifyOtp(
          verificationId: FirebaseAuthProvider.verifyId,
          otp: event.otp,
        );

        final firebaseMessagingToken = await provider.getFcmToken();

        if (token != null && firebaseMessagingToken != null) {
          await UserRepository.userSignUp(
            phone: state.phone!,
            businessName: state.businessName,
            contractor: state.contractor,
            token: token,
            fcmToken: firebaseMessagingToken,
            location: event.location,
            refCode: state.refCode,
          );
        } else {
          return emit(
            AuthErrorState(
              message: 'Something went wrong while connecting to the Firebase.',
              phone: state.phone,
              businessName: state.businessName,
              contractor: state.contractor,
              refCode: state.refCode,
            ),
          );
        }

        return emit(OtpVerifiedState());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'session-expired' || e.code == 'channel-error') {
          return emit(InitialState());
        }
        return emit(
          AuthErrorState(
            message: e.code,
            phone: state.phone,
            businessName: state.businessName,
            contractor: state.contractor,
            refCode: state.refCode,
          ),
        );
      } on BadRequestException {
        return emit(
          AuthErrorState(
            message: 'Invalid Referral Code',
            phone: state.phone,
            businessName: state.businessName,
            contractor: state.contractor,
            refCode: state.refCode,
          ),
        );
      } catch (e) {
        return emit(
          AuthErrorState(
            message: 'Something went wrong while connecting to the Server.',
            phone: state.phone,
            businessName: state.businessName,
            contractor: state.contractor,
            refCode: state.refCode,
          ),
        );
      }
    });

//====================Resend OTP Event====================//
    on<ResendOtpEvent>((event, emit) async {
      try {
        await provider.sendPhoneVerification(
          phone: event.phone,
          otpController: event.otpController,
        );
      } catch (e) {
        log('EXCEPTION IN RESEND OTP EVENT : $e');
      }
    });

//====================Sign Out Event====================//
    on<SignOutEvent>((event, emit) async {
      try {
        await provider.signOut();
        UserRepository.updateUserOnlineStatus(isOnline: false);
        Future.delayed(const Duration(milliseconds: 50), () {
          AppPreferences.clearSharedPreferences();
        });
      } catch (e) {
        log('EXCEPTION IN RESEND OTP EVENT : $e');
      }
    });
  }

//====================State Change Logger====================//
  @override
  void onChange(Change<AuthState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final authBloc = AuthBloc(FirebaseAuthProvider());
