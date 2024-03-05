import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/rewards/rewards_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/view/rewards/segments/round_prize_container.dart';

Widget mainPrizeSegment() {
  return BlocBuilder<RewardsBloc, RewardsState>(
    builder: (context, state) {
      return BlocBuilder<RewardsBloc, RewardsState>(
        builder: (context, state) {
          final rewardsModel = state.tabIndex == 0
              ? state.currentRewardsModel
              : state.previousRewardsModel;

          return Stack(
            alignment: Alignment.topCenter,
            children: [
              //====================First Prize Segment====================//
              Positioned(
                top: screenSize.height * .17,
                child: Column(
                  children: [
                    Text(
                      '1st Prize',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: screenSize.width * .031,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: screenSize.height * .01),
                    roundPrizeContainer(
                      imagePath:
                          '${ApiEndpoints.uploads}/${rewardsModel!.contestPrizes![0].image}',
                      backgroundColor: const Color.fromRGBO(255, 219, 73, 1),
                      shadowColor: const Color.fromRGBO(206, 166, 4, 1),
                    ),
                    SizedBox(height: screenSize.height * .01),
                    rewardsModel.contestPrizes![0].winnerDetails != null
                        ? CircleAvatar(
                            radius: screenSize.width * .044,
                            backgroundImage: NetworkImage(
                              rewardsModel
                                      .contestPrizes![0].winnerDetails!.image!
                                      .startsWith('http')
                                  ? rewardsModel
                                      .contestPrizes![0].winnerDetails!.image!
                                  : '${ApiEndpoints.uploads}/${rewardsModel.contestPrizes![0].winnerDetails!.image}',
                            ),
                          )
                        : const SizedBox(),
                    Text(
                      rewardsModel.contestPrizes![0].winnerDetails != null
                          ? rewardsModel.contestPrizes![0].winnerDetails!.name!
                              .split(' ')[0]
                          : 'No Participant',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .031,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              //====================Second Prize Segment====================//
              Positioned(
                top: screenSize.height * .34,
                left: screenSize.width * .051,
                child: Column(
                  children: [
                    Text(
                      '2nd Prize',
                      style: GoogleFonts.poppins(
                        fontSize: screenSize.width * .031,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: screenSize.height * .01),
                    roundPrizeContainer(
                      imagePath:
                          '${ApiEndpoints.uploads}/${rewardsModel.contestPrizes![1].image}',
                      backgroundColor: const Color.fromRGBO(255, 50, 56, 1),
                      shadowColor: const Color.fromRGBO(173, 0, 2, 1),
                    ),
                    SizedBox(height: screenSize.height * .01),
                    rewardsModel.contestPrizes![1].winnerDetails != null
                        ? CircleAvatar(
                            radius: screenSize.width * .044,
                            backgroundImage: NetworkImage(
                              rewardsModel
                                      .contestPrizes![1].winnerDetails!.image!
                                      .startsWith('http')
                                  ? rewardsModel
                                      .contestPrizes![1].winnerDetails!.image!
                                  : '${ApiEndpoints.uploads}/${rewardsModel.contestPrizes![1].winnerDetails?.image}',
                            ),
                          )
                        : const SizedBox(),
                    Text(
                      rewardsModel.contestPrizes![1].winnerDetails != null
                          ? rewardsModel.contestPrizes![1].winnerDetails!.name!
                              .split(' ')[0]
                              .toString()
                          : 'No Participant',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .031,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Text(
                    //   '100,000 Pts',
                    //   style: GoogleFonts.roboto(
                    //     color: const Color.fromRGBO(246, 147, 0, 1),
                    //     fontSize: screenSize.width * .032,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                  ],
                ),
              ),

              //====================Third Prize Segment====================//
              Positioned(
                top: screenSize.height * .34,
                right: screenSize.width * .051,
                child: Column(
                  children: [
                    Text(
                      '3rd Prize',
                      style: GoogleFonts.poppins(
                        fontSize: screenSize.width * .031,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: screenSize.height * .01),
                    roundPrizeContainer(
                      imagePath:
                          '${ApiEndpoints.uploads}/${rewardsModel.contestPrizes![2].image}',
                      backgroundColor: const Color.fromRGBO(23, 195, 196, 1),
                      shadowColor: const Color.fromRGBO(0, 151, 152, 1),
                    ),
                    SizedBox(height: screenSize.height * .01),
                    rewardsModel.contestPrizes![2].winnerDetails != null
                        ? CircleAvatar(
                            radius: screenSize.width * .044,
                            backgroundImage: NetworkImage(
                              rewardsModel
                                      .contestPrizes![2].winnerDetails!.image!
                                      .startsWith('http')
                                  ? rewardsModel
                                      .contestPrizes![2].winnerDetails!.image!
                                  : '${ApiEndpoints.uploads}/${rewardsModel.contestPrizes![2].winnerDetails?.image}',
                            ),
                          )
                        : const SizedBox(),
                    Text(
                      rewardsModel.contestPrizes![2].winnerDetails != null
                          ? rewardsModel.contestPrizes![2].winnerDetails!.name!
                              .split(' ')[0]
                              .toString()
                          : 'No Participant',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .031,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: screenSize.height * .58,
                child: Text(
                  rewardsModel.contestName.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: screenSize.width * .05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
