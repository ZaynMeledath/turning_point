part of '../lucky_draw_screen.dart';

//====================Whole Gift Box Segment in Lucky Draw Screen====================//
Widget giftBoxesSegment(BuildContext context) {
  return Column(
    children: [
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
