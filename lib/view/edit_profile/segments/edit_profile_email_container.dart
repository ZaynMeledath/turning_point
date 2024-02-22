part of '../edit_profile_screen.dart';

Widget editProfileEmailContainer({required String email}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
    child: Center(
      child: SizedBox(
        height: screenSize.height * .056 + (screenSize.height * .019) / 2,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
//====================Email Container====================//
            Container(
                width: double.infinity,
                height: screenSize.height * .056,
                padding: const EdgeInsets.only(left: 15, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 1,
                    color: const Color.fromRGBO(142, 142, 142, 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      email,
                      style: GoogleFonts.roboto(
                        letterSpacing: 1,
                        fontSize: screenSize.height * .017,
                        color: const Color.fromRGBO(16, 16, 16, 1),
                      ),
                    ),
                    Image.asset(
                      'assets/icons/google_logo.png',
                      width: screenSize.width * .1,
                    ),
                  ],
                )),
//====================floating Container Title====================//
            Positioned(
              top: 0,
              left: screenSize.width * .05,
              child: Container(
                height: screenSize.height * .019,
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * .028),
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Email',
                    style: GoogleFonts.inter(
                      fontSize: screenSize.width * .028,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}