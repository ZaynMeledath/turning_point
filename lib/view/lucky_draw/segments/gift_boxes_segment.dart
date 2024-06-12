part of '../lucky_draw_screen.dart';

//====================Whole Gift Box Segment in Lucky Draw Screen====================//
Widget giftBoxesSegment(BuildContext context) {
  return BlocBuilder<LuckyDrawBloc, LuckyDrawState>(
    builder: (context, luckyDrawState) {
      final prizeModelList = luckyDrawState.contestModel!.prizeArr!;
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              prizeModelList.isNotEmpty
                  ? GestureDetector(
                      onTap: () => CustomNavigator.push(
                        context: context,
                        child: const AllGiftsScreen(),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '#1',
                            style: GoogleFonts.poppins(
                              fontSize: screenSize.width * .035,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          giftBoxContainer(image: prizeModelList[0].image),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: screenSize.width * .24,
                      height: screenSize.width * .24,
                    ),
              prizeModelList.length > 1
                  ? GestureDetector(
                      onTap: () => CustomNavigator.push(
                        context: context,
                        child: const AllGiftsScreen(),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '#2',
                            style: GoogleFonts.poppins(
                              fontSize: screenSize.width * .035,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          giftBoxContainer(image: prizeModelList[1].image),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: screenSize.width * .24,
                      height: screenSize.width * .24,
                    ),
              prizeModelList.length > 2
                  ? GestureDetector(
                      onTap: () => CustomNavigator.push(
                        context: context,
                        child: const AllGiftsScreen(),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '#3',
                            style: GoogleFonts.poppins(
                              fontSize: screenSize.width * .035,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          giftBoxContainer(image: prizeModelList[2].image),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: screenSize.width * .24,
                      height: screenSize.width * .24,
                    ),
            ],
          ),
          SizedBox(height: screenSize.height * .019),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              prizeModelList.length > 3
                  ? GestureDetector(
                      onTap: () => CustomNavigator.push(
                        context: context,
                        child: const AllGiftsScreen(),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '#4',
                            style: GoogleFonts.poppins(
                              fontSize: screenSize.width * .035,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          giftBoxContainer(image: prizeModelList[3].image),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: screenSize.width * .24,
                      height: screenSize.width * .24,
                    ),
              prizeModelList.length > 4
                  ? GestureDetector(
                      onTap: () => CustomNavigator.push(
                        context: context,
                        child: const AllGiftsScreen(),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '#5',
                            style: GoogleFonts.poppins(
                              fontSize: screenSize.width * .035,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          giftBoxContainer(image: prizeModelList[4].image),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: screenSize.width * .24,
                      height: screenSize.width * .24,
                    ),
              prizeModelList.length > 5
                  ? GestureDetector(
                      onTap: () => CustomNavigator.push(
                        context: context,
                        child: const AllGiftsScreen(),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '#6',
                            style: GoogleFonts.poppins(
                              fontSize: screenSize.width * .035,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          giftBoxContainer(image: prizeModelList[4].image),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: screenSize.width * .24,
                      height: screenSize.width * .24,
                    ),
            ],
          ),
        ],
      );
    },
  );
}
