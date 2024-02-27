import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/points/points_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/bloc/redeem/redeem_bloc.dart';
import 'package:turning_point/dialog/custom_loading.dart';
import 'package:turning_point/dialog/show_coupon_generate_dialog.dart';
import 'package:turning_point/dialog/show_loading_dialog.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/view/redeem/segments/available_points_container.dart';
import 'package:turning_point/view/redeem/segments/redeem_options_segment.dart';

part 'segments/buy_coupons_segment.dart';
part 'segments/bank_transfer_segment.dart';
part 'segments/upi_transfer_segment.dart';
part 'segments/redeem_points_field_segment.dart';
part 'segments/redeem_plus_minus_container.dart';
part 'segments/your_amount_segment.dart';
part 'segments/account_details_segment.dart';
part 'segments/account_details_row.dart';
part 'segments/agree_terms_segment.dart';

class RedeemScreen extends StatefulWidget {
  const RedeemScreen({super.key});

  @override
  State<RedeemScreen> createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  dynamic closeDialogHandle;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//====================Header Segment with back button and title====================//
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(255, 229, 26, .8),
                    Color.fromRGBO(255, 235, 80, 0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  SafeArea(
                    child: customAppBar(context: context, title: 'Redeem'),
                  ),

//====================Available Points Segment====================//
                  availablePointsContainer(screenSize: screenSize),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * .04),

//====================Redeem Options Segment====================//
            redeemOptionsSegment(context: context, screenSize: screenSize),
            SizedBox(height: screenSize.height * .03),

//====================Redeem Options Body Segment====================//
            BlocConsumer<RedeemBloc, RedeemState>(
              listener: (context, state) {
                switch (state) {
                  case BuyCouponsState():
                    if (state.isLoading && closeDialogHandle == null) {
                      closeDialogHandle =
                          showCouponGenerateDialog(context: context);
                    } else if (!state.isLoading && closeDialogHandle != null) {
                      Navigator.pop(context);
                      closeDialogHandle = null;
                    }
                    break;
                  case BankTransferState():
                    if (state.isLoading && closeDialogHandle == null) {
                      closeDialogHandle = showLoadingDialog(context: context);
                    } else if (!state.isLoading && closeDialogHandle != null) {
                      Navigator.pop(context);
                      closeDialogHandle = null;
                    }
                    break;
                  case InAppPurchaseState():
                    if (state.isLoading && closeDialogHandle == null) {
                      closeDialogHandle = showLoadingDialog(context: context);
                    } else if (!state.isLoading && closeDialogHandle != null) {
                      Navigator.pop(context);
                      closeDialogHandle = null;
                    }
                    break;
                  case UpiTransferState():
                    if (state.isLoading && closeDialogHandle == null) {
                      closeDialogHandle = showLoadingDialog(context: context);
                    } else if (!state.isLoading && closeDialogHandle != null) {
                      Navigator.pop(context);
                      closeDialogHandle = null;
                    }
                    break;
                }
              },
              builder: (context, state) {
                switch (state) {
                  case BuyCouponsState():
                    return buyCouponsSegment(context: context);

                  case BankTransferState():
                    return bankTransferSegment(context: context);

                  case UpiTransferState():
                    return upiTransferSegment();

                  default:
                    return Column(
                      children: [
                        SizedBox(height: screenSize.height * .05),
                        spinningLinesLoading(),
                      ],
                    );
                }
              },
            ),
            SizedBox(height: screenSize.height * .02),
          ],
        ),
      ),
    );
  }
}
