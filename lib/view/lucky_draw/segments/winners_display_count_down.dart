part of '../winners_display_screen.dart';

Widget winnersDisplayCountDown() {
  return BlocBuilder<LuckyDrawBloc, LuckyDrawState>(
    builder: (context, state) {
      if (state.secondsLeft != null) {
        String seconds =
            ((state.secondsLeft! % LUCKY_DRAW_WINNER_DISPLAY_DELAY) + 1)
                .toString()
                .padLeft(2, '0');
        // String minutes = '00';
        return Column(
          children: [
            Text(
              state.secondsLeft! < 30
                  ? 'All Rewards List in'
                  : 'Next Winner in',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: screenSize.width * .036,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: screenSize.height * .015),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // DottedBorder(
                //   color: Colors.white,
                //   borderType: BorderType.RRect,
                //   radius: const Radius.circular(100),
                //   child: Container(
                //     width: screenSize.width * .15,
                //     height: screenSize.width * .15,
                //     color: Colors.transparent,
                //     child: Center(
                //       child: Text(
                //         minutes,
                //         style: GoogleFonts.inter(
                //           fontSize: screenSize.width * .06,
                //           fontWeight: FontWeight.w700,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(width: screenSize.width * .04),
                DottedBorder(
                  color: Colors.white,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(100),
                  child: Container(
                    width: screenSize.width * .15,
                    height: screenSize.width * .15,
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        seconds,
                        style: GoogleFonts.inter(
                          fontSize: screenSize.width * .06,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      } else {
        return const SizedBox();
      }
    },
  );
}
