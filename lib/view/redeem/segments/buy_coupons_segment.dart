part of '../redeem_screen.dart';

Widget buyCouponsSegment({
  required BuildContext context,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .061),
    child: Column(
      children: [
//====================Coupon Image====================//
        Image.asset(
          'assets/images/redeem_screen_gift_voucher.png',
          width: screenSize.width * .9,
        ),
        SizedBox(height: screenSize.height * .035),

//====================Points Field where points can be changed using + and - buttons====================//
        redeemPointsFieldSegment(),
        SizedBox(height: screenSize.height * .025),

//====================Amount in Rupees Segment====================//
        yourAmountSegment(),
        SizedBox(height: screenSize.height * .02),

//====================Redeem Button====================//
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
    ),
  );
}
