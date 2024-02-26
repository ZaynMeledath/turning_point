import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'kyc_event.dart';
part 'kyc_state.dart';

class KycBloc extends Bloc<KycEvent, KycState> {
  KycBloc() : super(const KycLoadingState()) {
//====================KYC Load Event====================//
    on<KycLoadEvent>((event, emit) async {
      log('KYCLOADEVENT USER MODEL :');
      final userModel = UserRepository.getUserFromPreference()!.data!;
      log('KYCLOADEVENT USER MODEL : ${userModel.name}, ${userModel.phone}, ${userModel.email}');
      if (userModel.bankDetails != null && userModel.bankDetails!.isNotEmpty) {
        emit(
          KycLoadedState(
            isLoading: false,
            tabIndex: event.tabIndex,
            isSavings: userModel.bankDetails?[0].banktype == 'savings',
            name: event.name ?? state.name ?? userModel.name!,
            phone: userModel.phone!,
            email: event.email ?? state.email ?? userModel.email!,
            pincode: event.pincode ?? state.pincode ?? userModel.pincode ?? '',
            idFrontImage: state.idFrontImage,
            idBackImage: state.idBackImage,
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
            pincode: event.pincode ?? state.pincode ?? userModel.pincode ?? '',
            idFrontImage: state.idFrontImage,
            idBackImage: state.idBackImage,
          ),
        );
      }
    });

//====================KYC ID Update Event====================//
    on<KycIdUpdateEvent>((event, emit) async {
      final imageMap = await UserRepository.fetchImageFromStorage();
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
          ),
        );
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
            name: event.name,
            phone: event.phone,
            email: event.email,
            pincode: event.pincode,
            idFrontImage: state.idFrontImage,
            idBackImage: state.idBackImage,
          ),
        );

        //---------------Assigning new values to the UserModel---------------//
        userModelResponse.data!.name = event.name;
        userModelResponse.data!.phone = event.phone;
        userModelResponse.data!.email = event.email;
        userModelResponse.data!.pincode = event.pincode;
        if (userModelResponse.data!.bankDetails != null &&
            userModelResponse.data!.bankDetails!.isNotEmpty) {
          userModelResponse.data!.bankDetails![0].accountName = event.accName;
          userModelResponse.data!.bankDetails![0].accountNo = event.accNum;
          userModelResponse.data!.bankDetails![0].ifsc = event.ifsc;
          userModelResponse.data!.bankDetails![0].banktype =
              event.isSavings ? 'savings' : 'current';
        } else {
          userModelResponse.data!.bankDetails = [
            BankDetails.fromJson({
              'accountName': event.accName,
              'accountNo': event.accNum,
              'ifsc': event.ifsc,
              'banktype': event.isSavings ? 'savings' : 'current',
            })
          ];
        }

        userModelResponse = await UserRepository.updateUserProfile(
          userModel: userModelResponse.data!,
          idFrontImage: state.idFrontImage,
          idBackImage: state.idBackImage,
        );

        emit(const KycSubmittedState());
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
