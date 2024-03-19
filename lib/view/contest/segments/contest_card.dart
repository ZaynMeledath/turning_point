part of '../contest_screen.dart';

Widget contestCard({
  required BuildContext context,
  required int index,
}) {
  return Container(
    width: double.infinity,
    height: screenSize.height * .32,
    margin: EdgeInsets.symmetric(horizontal: realScreenSize.width * .055),
    decoration: const BoxDecoration(
      color: Color.fromRGBO(255, 255, 255, 1),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          color: Color.fromRGBO(0, 0, 0, 0.25),
          blurRadius: 4,
          blurStyle: BlurStyle.outer,
        ),
      ],
    ),
    child: Column(
      children: [
        contestCardInnerContainer(context: context, index: index),
        SizedBox(height: screenSize.height * .01),
        Text(
          'Time Left',
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .03,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: screenSize.height * .007),
        BlocBuilder<ContestBloc, ContestState>(
          builder: (context, state) {
            switch (state) {
              case ContestLoadingState():
                return const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation(Colors.amber),
                  ),
                );
              case ContestLoadedState():
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    contestCountDownContainer(
                      time: state.timeList![index]['timeInDays']!,
                      title: 'DAYS',
                    ),
                    SizedBox(width: screenSize.width * .021),
                    contestCountDownContainer(
                      time: state.timeList![index]['timeInHours']!,
                      title: 'HOURS',
                    ),
                    SizedBox(width: screenSize.width * .021),
                    contestCountDownContainer(
                      time: state.timeList![index]['timeInMinutes']!,
                      title: 'MINUTES',
                    ),
                    SizedBox(width: screenSize.width * .021),
                    contestCountDownContainer(
                      time: state.timeList![index]['timeInSeconds']!,
                      title: 'SECONDS',
                    ),
                  ],
                );
            }
          },
        )
      ],
    ),
  );
}
