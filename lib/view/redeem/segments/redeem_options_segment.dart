import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/redeem/redeem_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget redeemOptionsSegment({
  required BuildContext context,
}) {
  return BlocBuilder<RedeemBloc, RedeemState>(
    builder: (context, state) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * .04),
        child: Column(
          children: [
            //First Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                        color: state.selectedOptionNumber == 1
                            ? const Color.fromRGBO(0, 99, 255, 1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: state.selectedOptionNumber != 1
                            ? [
                                const BoxShadow(
                                  offset: Offset(1.5, 2.5),
                                  color: Color.fromRGBO(218, 218, 218, .8),
                                ),
                                const BoxShadow(
                                  offset: Offset(-1.5, -1.5),
                                  color: Color.fromRGBO(218, 218, 218, .8),
                                ),
                              ]
                            : null
                        // border: state.selectedOptionNumber != 2
                        //     ? Border.all(
                        //         color: const Color.fromRGBO(218, 218, 218, 1),
                        //       )
                        //     : null,
                        ),
                    child: Text(
                      'Direct Bank Transfer',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .033,
                        fontWeight: FontWeight.w600,
                        color: state.selectedOptionNumber == 1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: screenSize.width * .1),

                //====================UPI Transfer Container====================//
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => redeemBloc.add(UpiTransferPressedEvent()),
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
                        boxShadow: state.selectedOptionNumber != 2
                            ? [
                                const BoxShadow(
                                  offset: Offset(1.5, 2.5),
                                  color: Color.fromRGBO(218, 218, 218, .8),
                                ),
                                const BoxShadow(
                                  offset: Offset(-1.5, -1.5),
                                  color: Color.fromRGBO(218, 218, 218, .8),
                                ),
                              ]
                            : null
                        // border: state.selectedOptionNumber != 4
                        //     ? Border.all(
                        //         color: const Color.fromRGBO(218, 218, 218, 1),
                        //       )
                        //     : null,
                        ),
                    child: Text(
                      'UPI Transfer',
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //====================Buy Coupons Container====================//
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => redeemBloc.add(BuyCouponsPressedEvent()),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .041,
                      vertical: screenSize.width * .019,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: state.selectedOptionNumber == 3
                            ? const Color.fromRGBO(0, 99, 255, 1)
                            : Colors.white,
                        boxShadow: state.selectedOptionNumber != 3
                            ? [
                                const BoxShadow(
                                  offset: Offset(1.5, 2.5),
                                  color: Color.fromRGBO(218, 218, 218, .8),
                                ),
                                const BoxShadow(
                                  offset: Offset(-1.5, -1.5),
                                  color: Color.fromRGBO(218, 218, 218, .8),
                                ),
                              ]
                            : null
                        // border: state.selectedOptionNumber != 1
                        //     ? Border.all(
                        //         color: const Color.fromRGBO(218, 218, 218, 1),
                        //       )
                        //     : null,
                        ),
                    child: Text(
                      'Buy Coupons',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .033,
                        color: state.selectedOptionNumber == 3
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w600,
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
