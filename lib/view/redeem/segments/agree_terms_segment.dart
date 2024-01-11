part of '../redeem_screen.dart';

Widget agreeTermsSegment() {
  return BlocBuilder<RedeemBloc, RedeemState>(
    builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              context.read<RedeemBloc>().add(AgreeTermsPressedEvent());
            },
            child: Container(
              width: screenSize.width * .041,
              height: screenSize.width * .041,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  width: 2,
                  color: const Color.fromRGBO(0, 99, 255, 1),
                ),
              ),
              child: Visibility(
                visible: state.isTermsAgreed,
                child: Center(
                  child: Container(
                    width: screenSize.width * .021,
                    height: screenSize.width * .021,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: const Color.fromRGBO(0, 99, 255, 1),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: screenSize.width * .031),
          Text(
            'I agree with the Terms and Conditions',
            style: GoogleFonts.roboto(
              fontSize: screenSize.width * .03,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
    },
  );
}
