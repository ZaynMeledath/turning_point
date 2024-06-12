part of '../reels_screen.dart';

Widget luckyDrawWatermark() {
  return BlocBuilder<LuckyDrawBloc, LuckyDrawState>(
    builder: (context, state) {
      if (state is LuckyDrawLoadedState &&
          state.secondsLeft != null &&
          state.secondsLeft! <= 3600) {
        return Opacity(
          opacity: .8,
          child: Column(
            children: [
              Image.asset(
                'assets/images/lucky_draw_watermark.png',
                width: screenSize.width * .22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // countDownContainerWatermark(
                  //   time: state.timeMap?['timeInHours'] ?? '00',
                  //   title: 'Hours',
                  // ),
                  // SizedBox(width: screenSize.width * .008),
                  countDownContainerWatermark(
                    time: state.timeMap?['timeInMinutes'] ?? '00',
                    title: 'Minutes',
                  ),
                  SizedBox(width: screenSize.width * .01),
                  countDownContainerWatermark(
                    time: state.timeMap?['timeInSeconds'] ?? '00',
                    title: 'Seconds',
                  ),
                ],
              ),
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    },
  );
}
