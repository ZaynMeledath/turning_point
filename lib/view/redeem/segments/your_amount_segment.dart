part of '../redeem_screen.dart';

Widget yourAmountSegment() {
  return Column(
    children: [
      Text(
        'Your Amount',
        style: GoogleFonts.roboto(
          fontSize: screenSize.width * .041,
          fontWeight: FontWeight.w500,
        ),
      ),
      BlocBuilder<RedeemBloc, RedeemState>(
        builder: (context, state) {
          final pointsToRupees = (state.redeemPoints ~/ 5);
          return Text(
            '₹$pointsToRupees',
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
