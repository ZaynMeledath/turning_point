part of '../redeem_screen.dart';

Widget redeemPlusMinusContainer({required bool isPlus}) {
  return BlocBuilder<RedeemBloc, RedeemState>(
    builder: (context, state) {
      return Container(
        width: screenSize.width * .11,
        height: screenSize.width * .11,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(
            right: isPlus ? const Radius.circular(8) : const Radius.circular(0),
            left: !isPlus ? const Radius.circular(8) : const Radius.circular(0),
          ),
        ),
        child: Center(
          child: isPlus
              ? Image.asset(
                  'assets/icons/redeem_plus_icon.png',
                  width: screenSize.width * .05,
                  color:
                      (state.redeemPoints + 500) > 10000 ? Colors.grey : null,
                )
              : Image.asset(
                  'assets/icons/redeem_minus_icon.png',
                  width: screenSize.width * .05,
                  color: state.redeemPoints == 500 ? Colors.grey : null,
                ),
        ),
      );
    },
  );
}
