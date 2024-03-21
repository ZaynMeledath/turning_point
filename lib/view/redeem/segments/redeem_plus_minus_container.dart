part of '../redeem_screen.dart';

Widget redeemPlusMinusContainer({required bool isPlus}) {
  return BlocBuilder<RedeemBloc, RedeemState>(
    builder: (context, state) {
      final user = UserRepository.getUserFromPreference()!;
      return Container(
        width: screenSize.width * .11,
        height: screenSize.width * .11,
        // margin: EdgeInsets.symmetric(horizontal: screenSize.width * .01),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(100),
          borderRadius: BorderRadius.horizontal(
            right:
                isPlus ? const Radius.circular(30) : const Radius.circular(0),
            left:
                !isPlus ? const Radius.circular(30) : const Radius.circular(0),
          ),
        ),

//====================Changes state according to the value====================//
        child: Center(
          child: isPlus
              ? Image.asset(
                  'assets/icons/redeem_plus_icon.png',
                  width: screenSize.width * .05,
                  color: (state.redeemPoints + 500) > user.data!.points!
                      ? Colors.grey
                      : null,
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
