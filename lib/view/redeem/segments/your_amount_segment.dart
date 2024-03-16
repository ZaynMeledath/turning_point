part of '../redeem_screen.dart';

Widget yourAmountSegment() {
  return Column(
    children: [
//====================Title====================//
      Text(
        'Your Amount',
        style: GoogleFonts.roboto(
          fontSize: screenSize.width * .041,
          fontWeight: FontWeight.w500,
        ),
      ),

//====================Amount in Rupees Segment====================//
      BlocBuilder<RedeemBloc, RedeemState>(
        builder: (context, state) {
          return Text(
            '₹${state.redeemPoints}',
            style: GoogleFonts.roboto(
              fontSize: screenSize.width * .07,
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(3, 151, 0, 1),
            ),
          );
        },
      ),
    ],
  );
}
