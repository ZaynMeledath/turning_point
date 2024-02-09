part of '../redeem_screen.dart';

Widget redeemPointsFieldSegment() {
  return BlocBuilder<RedeemBloc, RedeemState>(
    builder: (context, state) {
      return Column(
        children: [
//====================Title====================//
          Text(
            'Enter the Points you want to Redeem',
            style: GoogleFonts.roboto(
              fontSize: screenSize.width * .04,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: screenSize.height * .01),

//====================Points Field Container (Can change points using the + & - buttons)====================//
          Container(
            width: screenSize.width * .75,
            height: screenSize.width * .11,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(246, 246, 246, 1),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(2, 3),
                  color: Color.fromRGBO(218, 218, 218, .8),
                ),
                BoxShadow(
                  offset: Offset(-2, -1),
                  color: Color.fromRGBO(218, 218, 218, .8),
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
                      '${state.redeemPoints}',
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
          const SizedBox(height: 5),

//====================Note====================//
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Note: ',
                style: GoogleFonts.roboto(
                  color: const Color.fromRGBO(228, 37, 43, 1),
                  fontSize: screenSize.width * .028,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Five points is equal to one rupee',
                style: GoogleFonts.roboto(
                  fontSize: screenSize.width * .028,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}