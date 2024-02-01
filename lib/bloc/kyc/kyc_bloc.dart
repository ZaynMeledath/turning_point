import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'kyc_event.dart';
part 'kyc_state.dart';

class KycBloc extends Bloc<KycEvent, KycState> {
  KycBloc() : super(KycLoadingState()) {
//====================KYC Load Event====================//
    on<KycLoadEvent>((event, emit) {
      final userModel = UserRepository.getUserFromPreference()!.data!;
      emit(
        KycLoadedState(
          isLoading: false,
          name: userModel.name!,
          phone: userModel.phone!,
          email: userModel.email!,
          pincode: userModel.pincode ?? '',
        ),
      );
    });

//====================KYC Update Event====================//
    on<KycUpdateEvent>((event, emit) async {
      try {
        UserModelResponse? userModelResponse =
            UserRepository.getUserFromPreference();
        final userModel = userModelResponse!.data!;

        emit(
          KycLoadedState(
            isLoading: true,
            name: userModel.name!,
            phone: userModel.phone!,
            email: userModel.email!,
            pincode: userModel.pincode ?? '',
          ),
        );

        //---------------Assigning new values to the UserModel---------------//
        userModelResponse.data!.name = event.name;
        userModelResponse.data!.phone = event.phone;
        userModelResponse.data!.email = event.email;
        userModelResponse.data!.pincode = event.pincode;
        userModelResponse.data!.bankDetails![0].accountName = event.accName;
        userModelResponse.data!.bankDetails![0].accountNo =
            int.parse(event.accNum);
        userModelResponse.data!.bankDetails![0].ifsc = event.ifsc;
        userModelResponse.data!.bankDetails![0].banktype =
            event.isSavings ? 'savings' : 'current';

        userModelResponse = await UserRepository.updateUserProfile(
          userModel: userModelResponse.data!,
          isKyc: true,
        );

        emit(KycSubmittedState());
      } catch (_) {}
    });
  }
}
