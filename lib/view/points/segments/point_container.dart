part of '../points_screen.dart';

Widget pointContainer({
  required PointsHistoryModel pointsHistoryModel,
}) {
  final isCredited = pointsHistoryModel.type == 'CREDIT';
  return Container(
    margin: EdgeInsets.only(bottom: screenSize.height * .018),
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .026),
    height: screenSize.height * .067,
    decoration: BoxDecoration(
      // color: isCredited ? Colors.white : const Color.fromRGBO(255, 245, 245, 1),
      color: isCredited ? Colors.white : const Color(0xFFFFEFEF),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 1),
          blurRadius: 4,
          color: Colors.black.withOpacity(.07),
        )
      ],
    ),
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
//====================Title (Credited or Debited) and respective icon====================//
        Positioned(
          left: 0,
          child: Text(
            isCredited ? 'Credited' : 'Debited',
            style: GoogleFonts.roboto(
              fontSize: screenSize.width * .036,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Positioned(
          left: screenSize.width * .155,
          child: Image.asset(
            isCredited
                ? 'assets/icons/arrow_up.png'
                : 'assets/icons/arrow_down.png',
            width: screenSize.width * .021,
          ),
        ),
//====================Date of Transaction====================//
        Positioned(
          left: screenSize.width * .26,
          child: Text(
            pointsHistoryModel.createdAt!,
            style: GoogleFonts.roboto(
              fontSize: screenSize.width * .026,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(.5),
            ),
          ),
        ),

//====================Transaction Description====================//
        Positioned(
          left: screenSize.width * .44,
          child: SizedBox(
            width: screenSize.width * .2,
            child: Center(
              child: Text(
                pointsHistoryModel.mobileDescription.toString(),
                textAlign: TextAlign.center,
                // overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                    fontSize: screenSize.width * .03,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(.6)),
              ),
            ),
          ),
        ),

//====================Trailing Points Transaction Amount Container====================//
        Positioned(
          right: 0,
          child: Container(
            height: screenSize.height * .03,
            padding: const EdgeInsets.only(
              left: 2,
              right: 6,
              top: 3,
              bottom: 3,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color.fromRGBO(255, 215, 0, 1),
                  Color.fromRGBO(255, 238, 141, 1),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/icons/coin_icon.png',
                  width: 29,
                ),
                Text(
                  pointsHistoryModel.amount.toString(),
                  style: GoogleFonts.inter(
                    fontSize: screenSize.width * .031,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
