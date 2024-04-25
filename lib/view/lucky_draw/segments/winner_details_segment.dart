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
    child: rewardsModel.contestPrizes![prizeIndex].winnerDetails != null
        ? Column(
            children: [
              Image.asset(
                'assets/icons/golden_crown_icon.png',
                width: screenSize.width * .1,
              ),
              SizedBox(height: screenSize.height * .005),
              Container(
                width: screenSize.height * .06,
                height: screenSize.height * .06,
                padding: EdgeInsets.all(screenSize.height * .005),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(235, 165, 65, 1),
                      Color.fromRGBO(247, 218, 75, 1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    rewardsModel
                            .contestPrizes![prizeIndex].winnerDetails!.image!
                            .startsWith('http')
                        ? rewardsModel
                            .contestPrizes![prizeIndex].winnerDetails!.image!
                        : '${ApiEndpoints.uploads}/${rewardsModel.contestPrizes![prizeIndex].winnerDetails!.image}',
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * .01),
              Text(
                rewardsModel.contestPrizes![prizeIndex].winnerDetails != null
                    ? rewardsModel
                        .contestPrizes![prizeIndex].winnerDetails!.name!
                    : 'No Participant',
                style: GoogleFonts.poppins(
                  fontSize: screenSize.width * .036,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          )
        : const SizedBox(),
  );
}





// DefaultTextStyle(
//           style: GoogleFonts.inter(
//             fontSize: screenSize.width * .05,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//           child: Text((prizeIndex + 1).toString()),
//         ),

// CircleAvatar(
//                     radius: screenSize.width * .05,
//                     foregroundImage: NetworkImage(
//                       rewardsModel
//                               .contestPrizes![prizeIndex].winnerDetails!.image!
//                               .startsWith('http')
//                           ? rewardsModel
//                               .contestPrizes![prizeIndex].winnerDetails!.image!
//                           : '${ApiEndpoints.uploads}/${rewardsModel.contestPrizes![prizeIndex].winnerDetails!.image}',

//                     ),
//                   )



// Align(
//           alignment: Alignment.center,
//           child: Image.network(
//             rewardsModel.contestPrizes![prizeIndex].image.toString(),
//             height: screenSize.height * .085,
//           ),
//         ),