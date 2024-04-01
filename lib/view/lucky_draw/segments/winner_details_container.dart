part of '../winners_display_screen.dart';

Widget winnerDetailsSegment({
  required RewardsModel rewardsModel,
  required int prizeIndex,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: screenSize.width * .03,
      vertical: screenSize.height * .01,
    ),
    child: Column(
      children: [
        Stack(
          children: [
            DefaultTextStyle(
              style: GoogleFonts.inter(
                fontSize: screenSize.width * .05,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              child: Text((prizeIndex + 1).toString()),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.network(
                rewardsModel.contestPrizes![prizeIndex].image.toString(),
                height: screenSize.height * .085,
              ),
            ),
          ],
        ),
        SizedBox(height: screenSize.height * .012),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            rewardsModel.contestPrizes![prizeIndex].winnerDetails != null
                ? CircleAvatar(
                    radius: screenSize.width * .05,
                    backgroundImage: NetworkImage(
                      rewardsModel
                              .contestPrizes![prizeIndex].winnerDetails!.image!
                              .startsWith('http')
                          ? rewardsModel
                              .contestPrizes![prizeIndex].winnerDetails!.image!
                          : '${ApiEndpoints.uploads}/${rewardsModel.contestPrizes![prizeIndex].winnerDetails!.image}',
                    ),
                  )
                : const SizedBox(),
            SizedBox(width: screenSize.width * .04),
            Text(
              rewardsModel.contestPrizes![prizeIndex].winnerDetails != null
                  ? rewardsModel.contestPrizes![prizeIndex].winnerDetails!.name!
                  : 'No Participant',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .045,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
