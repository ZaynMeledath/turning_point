import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/redeem/redeem_bloc.dart';

Widget redeemOptionsSegment({
  required BuildContext context,
  required Size screenSize,
}) {
  return BlocBuilder<RedeemBloc, RedeemState>(
    builder: (context, state) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * .04),
        child: Column(
          children: [
            //First Row
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
//====================Buy Coupons Container====================//
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () =>
                      context.read<RedeemBloc>().add(BuyCouponsPressedEvent()),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .041,
                      vertical: screenSize.width * .019,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: state.selectedOptionNumber == 1
                          ? const Color.fromRGBO(0, 99, 255, 1)
                          : Colors.white,
                      border: state.selectedOptionNumber != 1
                          ? Border.all(
                              color: const Color.fromRGBO(218, 218, 218, 1),
                            )
                          : null,
                    ),
                    child: Text(
                      'Buy Coupons',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .033,
                        color: state.selectedOptionNumber == 1
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width * .025),

//====================Bank Transfer Container====================//
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => context
                      .read<RedeemBloc>()
                      .add(BankTransferPressedEvent()),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .041,
                      vertical: screenSize.width * .019,
                    ),
                    decoration: BoxDecoration(
                      color: state.selectedOptionNumber == 2
                          ? const Color.fromRGBO(0, 99, 255, 1)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: state.selectedOptionNumber != 2
                          ? Border.all(
                              color: const Color.fromRGBO(218, 218, 218, 1),
                            )
                          : null,
                    ),
                    child: Text(
                      'Direct Bank Transfer',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .033,
                        fontWeight: FontWeight.w600,
                        color: state.selectedOptionNumber == 2
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenSize.height * .019),

            //Second Row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
//====================In-App Purchase Container====================//
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => context
                      .read<RedeemBloc>()
                      .add(InAppPurchasePressedEvent()),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .041,
                      vertical: screenSize.width * .019,
                    ),
                    decoration: BoxDecoration(
                      color: state.selectedOptionNumber == 3
                          ? const Color.fromRGBO(0, 99, 255, 1)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: state.selectedOptionNumber != 3
                          ? Border.all(
                              color: const Color.fromRGBO(218, 218, 218, 1),
                            )
                          : null,
                    ),
                    child: Text(
                      'In-App Purchase',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .033,
                        fontWeight: FontWeight.w600,
                        color: state.selectedOptionNumber == 3
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width * .025),

//====================UPI Transfer Container====================//
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () =>
                      context.read<RedeemBloc>().add(UpiTransferPressedEvent()),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .041,
                      vertical: screenSize.width * .019,
                    ),
                    decoration: BoxDecoration(
                      color: state.selectedOptionNumber == 4
                          ? const Color.fromRGBO(0, 99, 255, 1)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: state.selectedOptionNumber != 4
                          ? Border.all(
                              color: const Color.fromRGBO(218, 218, 218, 1),
                            )
                          : null,
                    ),
                    child: Text(
                      'UPI Transfer',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .033,
                        fontWeight: FontWeight.w600,
                        color: state.selectedOptionNumber == 4
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
