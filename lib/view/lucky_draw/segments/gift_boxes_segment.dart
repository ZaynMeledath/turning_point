part of '../lucky_draw_screen.dart';

//====================Whole Gift Box Segment in Lucky Draw Screen====================//
Widget giftBoxesSegment(BuildContext context) {
  return Column(
    children: [
      BlocBuilder<LuckyDrawBloc, LuckyDrawState>(
        builder: (context, luckyDrawState) {
          final prizeModelList = luckyDrawState.contestModel!.prizeArr!;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => CustomNavigator.push(
                  context: context,
                  child: const AllGiftsScreen(),
                ),
                child: giftBoxContainer(image: prizeModelList[0].image),
              ),
              GestureDetector(
                onTap: () => CustomNavigator.push(
                  context: context,
                  child: const AllGiftsScreen(),
                ),
                child: giftBoxContainer(image: prizeModelList[1].image),
              ),
              GestureDetector(
                onTap: () => CustomNavigator.push(
                  context: context,
                  child: const AllGiftsScreen(),
                ),
                child: giftBoxContainer(image: prizeModelList[2].image),
              ),
            ],
          );
        },
      ),
      SizedBox(height: screenSize.height * .019),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => CustomNavigator.push(
              context: context,
              child: const AllGiftsScreen(),
            ),
            child: giftBoxContainer(),
          ),
          GestureDetector(
            onTap: () => CustomNavigator.push(
              context: context,
              child: const AllGiftsScreen(),
            ),
            child: giftBoxContainer(),
          ),
          GestureDetector(
            onTap: () => CustomNavigator.push(
              context: context,
              child: const AllGiftsScreen(),
            ),
            child: giftBoxContainer(),
          ),
        ],
      ),
    ],
  );
}
