part of '../redeem_screen.dart';

Widget redeemTextFieldSegment({
  required Size screenSize,
  required BuildContext context,
}) {
  final redeemBloc = context.watch<RedeemBloc>();

  return Column(
    children: [
      Text(
        'Enter the Points you want to Redeem',
        style: GoogleFonts.roboto(
          fontSize: screenSize.width * .04,
          fontWeight: FontWeight.w400,
        ),
      ),
      SizedBox(height: screenSize.height * .01),
      Container(
        width: double.infinity,
        height: screenSize.width * .11,
        margin: EdgeInsets.symmetric(horizontal: screenSize.width * .07),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(246, 246, 246, 1),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 1.5,
              color: Colors.black.withOpacity(.25),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                context.read<RedeemBloc>().add(PointsDecrementEvent());
              },
              child: redeemPlusMinusContainer(isPlus: false),
            ),
            Row(
              children: [
                Image.asset(
                  'assets/icons/redeem_screen_coin_icon.png',
                  width: screenSize.width * .061,
                ),
                const SizedBox(width: 1),
                Text(
                  '${redeemBloc.state.redeemPoints}',
                  style: GoogleFonts.roboto(
                    fontSize: screenSize.width * .05,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                context.read<RedeemBloc>().add(PointsIncrementEvent());
              },
              child: redeemPlusMinusContainer(isPlus: true),
            ),
          ],
        ),
      ),
    ],
  );
}
