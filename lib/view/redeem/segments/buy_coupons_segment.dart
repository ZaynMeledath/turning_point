part of '../redeem_screen.dart';

Widget buyCouponsSegment({
  required BuildContext context,
  required TextEditingController controller,
}) {
  return Column(
    children: [
      Image.asset(
        'assets/images/redeem_screen_gift_voucher.png',
        width: screenSize.width * .9,
      ),
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
            'One point is equal to one rupee',
            style: GoogleFonts.roboto(
              fontSize: screenSize.width * .028,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      SizedBox(height: screenSize.height * .035),
      redeemTextFieldSegment(screenSize: screenSize, controller: controller),
      SizedBox(height: screenSize.height * .025),
      Text(
        'Your Amount',
        style: GoogleFonts.roboto(
          fontSize: screenSize.width * .041,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        '₹500',
        style: GoogleFonts.roboto(
          fontSize: screenSize.width * .07,
          fontWeight: FontWeight.w500,
          color: const Color.fromRGBO(3, 151, 0, 1),
        ),
      ),
      SizedBox(height: screenSize.height * .02),
      GestureDetector(
        onTap: () async {
          showCouponGenerateDialog(context: context);
          await Future.delayed(
            const Duration(milliseconds: 2000),
            () {
              Navigator.pop(context);
            },
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * .1,
            vertical: screenSize.width * .021,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(0, 99, 255, 1),
          ),
          child: Text(
            'Redeem',
            style: GoogleFonts.inter(
              fontSize: screenSize.width * .031,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
      SizedBox(height: screenSize.height * .019),
    ],
  );
}
