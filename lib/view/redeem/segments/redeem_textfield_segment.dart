part of '../redeem_screen.dart';

Widget redeemTextFieldSegment({
  required Size screenSize,
  required TextEditingController controller,
}) {
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
        margin: EdgeInsets.symmetric(horizontal: screenSize.width * .05),
        padding: EdgeInsets.only(
          left: screenSize.width * .05,
          right: screenSize.width * .03,
        ),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(246, 246, 246, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                style: GoogleFonts.inter(
                  fontSize: screenSize.width * .035,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(bottom: screenSize.width * .016),
                  hintText: 'Enter the points you want to redeem',
                  hintStyle: GoogleFonts.inter(
                    fontSize: screenSize.width * .035,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Image.asset(
              'assets/icons/redeem_screen_coin_icon.png',
              width: screenSize.width * .061,
            ),
          ],
        ),
      ),
    ],
  );
}
