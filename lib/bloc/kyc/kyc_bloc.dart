import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'kyc_event.dart';
part 'kyc_state.dart';

class KycBloc extends Bloc<KycEvent, KycState> {
  KycBloc() : super(const KycLoadingState()) {
//====================KYC Load Event====================//
    on<KycLoadEvent>((event, emit) async {
      try {
        final userModel = UserRepository.getUserFromPreference()!.data!;

        if (event.avoidStatusCheck != true) {
          switch (userModel.kycStatus) {
//====================Kyc Submitted State====================//
            case KycStatus.SUBMITTED:
              return emit(
                KycVerifiedState(
                  isSavings: userModel.bankDetails?[0].banktype == 'savings',
                  name: event.name ?? state.name ?? userModel.name!,
                  phone: userModel.phone!,
                  email: event.email ?? state.email ?? userModel.email!,
                  pincode:
                      event.pincode ?? state.pincode ?? userModel.pincode ?? '',
                  idFrontImage: state.idFrontImage ?? userModel.idFrontImage,
                  idBackImage: state.idBackImage ?? userModel.idBackImage,
                  selfie: state.selfie ?? userModel.selfie,
                ),
              );

//====================Kyc Verified State====================//
            case KycStatus.APPROVED:
              return emit(
                KycVerifiedState(
                  isSavings: userModel.bankDetails?[0].banktype == 'savings',
                  name: event.name ?? state.name ?? userModel.name!,
                  phone: userModel.phone!,
                  email: event.email ?? state.email ?? userModel.email!,
                  pincode:
                      event.pincode ?? state.pincode ?? userModel.pincode ?? '',
                  idFrontImage: state.idFrontImage ?? userModel.idFrontImage,
                  idBackImage: state.idBackImage ?? userModel.idBackImage,
                  selfie: state.selfie ?? userModel.selfie,
                ),
              );

//====================Kyc Rejected State====================//
            case KycStatus.REJECTED:
              return emit(
                KycRejectedState(
                  isSavings: userModel.bankDetails?[0].banktype == 'savings',
                  name: event.name ?? state.name ?? userModel.name!,
                  phone: userModel.phone!,
                  email: event.email ?? state.email ?? userModel.email!,
                  pincode:
                      event.pincode ?? state.pincode ?? userModel.pincode ?? '',
                  idFrontImage: state.idFrontImage ?? userModel.idFrontImage,
                  idBackImage: state.idBackImage ?? userModel.idBackImage,
                  selfie: state.selfie ?? userModel.selfie,
                ),
              );

            default:
              break;
          }
        }

        if (userModel.bankDetails != null &&
            userModel.bankDetails!.isNotEmpty) {
          emit(
            KycLoadedState(
              isLoading: false,
              tabIndex: event.tabIndex,
              isSavings: userModel.bankDetails?[0].banktype == 'savings',
              name: event.name ?? state.name ?? userModel.name!,
              phone: userModel.phone!,
              email: event.email ?? state.email ?? userModel.email!,
              pincode:
                  event.pincode ?? state.pincode ?? userModel.pincode ?? '',
              idFrontImage: state.idFrontImage ?? userModel.idFrontImage,
              idBackImage: state.idBackImage ?? userModel.idBackImage,
              selfie: state.selfie ?? userModel.selfie,
            ),
          );
        } else {
          emit(
            KycLoadedState(
              isLoading: false,
              tabIndex: event.tabIndex,
              isSavings: true,
              name: event.name ?? state.name ?? userModel.name!,
              phone: userModel.phone!,
              email: event.email ?? state.email ?? userModel.email!,
              pincode:
                  event.pincode ?? state.pincode ?? userModel.pincode ?? '',
              idFrontImage: state.idFrontImage ?? userModel.idFrontImage,
              idBackImage: state.idBackImage ?? userModel.idBackImage,
              selfie: state.selfie ?? userModel.selfie,
            ),
          );
        }
      } catch (_) {
        return emit(const KycErrorState());
      }
    });

//====================KYC ID Update Event====================//
    on<KycIdUpdateEvent>((event, emit) async {
      try {
        final imageMap =
            await UserRepository.fetchAndConvertImageToBase64(isId: true);
        if (imageMap != null) {
          emit(
            KycLoadedState(
              isLoading: false,
              tabIndex: 1,
              isSavings: state.isSavings,
              name: state.name,
              phone: state.phone,
              email: state.email,
              pincode: state.pincode,
              idFrontImage: state.idFrontImage ?? imageMap.keys.first,
              idBackImage:
                  state.idFrontImage != null ? imageMap.keys.first : null,
              idDisplayImage: File(imageMap.values.first.path),
              selfie: null,
            ),
          );
        }
      } catch (e) {
        throw Exception(e);
      }
    });

//====================KYC ID Reset Event====================//
    on<KycIdResetEvent>((event, emit) {
      emit(
        KycLoadedState(
          isLoading: false,
          tabIndex: 1,
          isSavings: state.isSavings,
          name: state.name,
          phone: state.phone,
          email: state.email,
          pincode: state.pincode,
          idFrontImage: null,
          idBackImage: null,
          idDisplayImage: null,
          selfie: null,
        ),
      );
    });

//====================KYC Selfie Reset Event====================//
    on<KycSelfieUpdateEvent>((event, emit) async {
      try {
        final imageMap =
            await UserRepository.fetchAndConvertImageToBase64(isSelfie: true);
        if (imageMap != null) {
          emit(
            KycLoadedState(
              isLoading: false,
              tabIndex: 1,
              isSavings: state.isSavings,
              name: state.name,
              phone: state.phone,
              email: state.email,
              pincode: state.pincode,
              idFrontImage: state.idFrontImage,
              idBackImage: state.idBackImage,
              idDisplayImage: File(imageMap.values.first.path),
              selfie: imageMap.keys.first,
            ),
          );
        }
      } catch (e) {
        throw Exception(e);
      }
    });

//====================KYC Update Event====================//
    on<KycUpdateEvent>((event, emit) async {
      try {
        UserModelResponse? userModelResponse =
            UserRepository.getUserFromPreference()!;

        emit(
          KycLoadedState(
            isLoading: true,
            tabIndex: 2,
            isSavings: event.isSavings,
            name: state.name,
            phone: state.phone,
            email: state.email,
            pincode: state.pincode,
            idFrontImage: state.idFrontImage,
            idBackImage: state.idBackImage,
            selfie: state.selfie,
          ),
        );

        //---------------Assigning new values to the UserModel---------------//
        userModelResponse.data!.name = state.name;
        userModelResponse.data!.phone = state.phone;
        userModelResponse.data!.email = state.email;
        userModelResponse.data!.pincode = state.pincode;
        userModelResponse.data!.idFrontImage = state.idFrontImage;
        userModelResponse.data!.idBackImage = state.idBackImage;
        userModelResponse.data!.selfie = state.selfie;
        if (userModelResponse.data!.bankDetails != null &&
            userModelResponse.data!.bankDetails!.isNotEmpty) {
          userModelResponse.data!.bankDetails![0].accountName = event.accName;
          userModelResponse.data!.bankDetails![0].accountNo = event.accNum;
          userModelResponse.data!.bankDetails![0].ifsc = event.ifsc;
          userModelResponse.data!.bankDetails![0].banktype =
              event.isSavings ? 'savings' : 'current';
        } else {
          userModelResponse.data!.bankDetails = [
            BankDetails(
              accountName: event.accName,
              accountNo: event.accNum,
              ifsc: event.ifsc,
              banktype: event.isSavings ? 'savings' : 'current',
            )
          ];
        }

        userModelResponse = await UserRepository.updateUserProfile(
          userModel: userModelResponse.data!,
        );
        profileBloc.add(ProfileLoadEvent());

        return emit(
          KycSubmittedState(
            isSavings: event.isSavings,
            name: state.name,
            phone: state.phone,
            email: state.email,
            pincode: state.pincode,
            idFrontImage: state.idFrontImage,
            idBackImage: state.idBackImage,
            selfie: state.selfie,
          ),
        );
      } catch (_) {}
    });

//====================KYC Account Type Trigger Event====================//
    on<KycAccountTypeTriggerEvent>((event, emit) {
      emit(
        KycLoadedState(
          isLoading: false,
          tabIndex: 2,
          isSavings: event.isSavings,
          name: state.name,
          email: state.email,
          phone: state.phone,
          pincode: state.pincode,
          idFrontImage: state.idFrontImage,
          idBackImage: state.idBackImage,
          selfie: state.selfie,
        ),
      );
    });
  }

//====================State Change Logger====================//
  @override
  void onChange(Change<KycState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final kycBloc = KycBloc();
