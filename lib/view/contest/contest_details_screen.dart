part of 'contest_screen.dart';

class ContestDetailsScreen extends StatelessWidget {
  final ContestModel contestModel;
  final int index;
  const ContestDetailsScreen({
    required this.contestModel,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ContestBloc, ContestState>(
          builder: (context, state) {
            return Column(
              children: [
                customAppBar(context: context, title: 'Contest Details'),
                SizedBox(height: screenSize.height * .01),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * .041,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      'assets/images/daily_contest_banner.png',
                    ),
                  ),
                ),

                //====================Contest Details Container Segment====================//
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: screenSize.height * .014,
                      horizontal: screenSize.width * .041,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .031,
                      vertical: screenSize.width * .028,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            color: Color.fromRGBO(0, 0, 0, .25),
                          ),
                        ]),
                    child: ListView(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: screenSize.width * .03),
                                SizedBox(
                                  width: screenSize.width * .42,
                                  child: Text(
                                    contestModel.name!,
                                    style: GoogleFonts.poppins(
                                      fontStyle: FontStyle.italic,
                                      fontSize: screenSize.width * .041,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromRGBO(0, 31, 36, 1),
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenSize.height * .005),
                                Row(
                                  children: [
                                    Text(
                                      contestModel.points.toString(),
                                      style: GoogleFonts.roboto(
                                        fontSize: screenSize.width * .08,
                                        fontWeight: FontWeight.w600,
                                        color: const Color.fromRGBO(
                                            245, 146, 0, 1),
                                      ),
                                    ),
                                    SizedBox(width: screenSize.width * .014),
                                    Column(
                                      children: [
                                        SizedBox(
                                            height: screenSize.width * .014),
                                        Text(
                                          'Points',
                                          style: GoogleFonts.roboto(
                                            fontSize: screenSize.width * .04,
                                            fontWeight: FontWeight.w600,
                                            color: const Color.fromRGBO(
                                                26, 26, 26, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              width: screenSize.width * .39,
                              height: screenSize.width * .39,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(255, 250, 217, 1),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: screenSize.width * .05),
                                  Image.asset(
                                    'assets/images/contest_details_gifts_image.png',
                                    width: screenSize.width * .354,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * .012),
                        Text(
                          'Join The Contest and Win Exciting Prizes!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: screenSize.width * .025,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        SizedBox(height: screenSize.height * .008),
                        Text(
                          contestModel.description!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            height: 2,
                            fontSize: screenSize.width * .03,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(0, 29, 75, 1),
                          ),
                        ),
                        SizedBox(height: screenSize.height * .01),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Contest Rules',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              height: 2,
                              fontSize: screenSize.width * .041,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(0, 29, 75, 1),
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.wavy,
                            ),
                          ),
                        ),
                        for (int i = 0; i < contestModel.rulesArr!.length; i++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '⦿  ${contestModel.rulesArr![i]}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  height: 2,
                                  fontSize: screenSize.width * .03,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(0, 29, 75, 1),
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Time Left',
                  style: GoogleFonts.roboto(
                    fontSize: screenSize.width * .03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenSize.height * .007),
                //====================Contest Count Down Timer Segment====================//

                Row(
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
                ),

                SizedBox(height: screenSize.height * .028),

                //====================Enter Contest Button====================//
                GestureDetector(
                  onTap: () {
                    if (state.contestModelList![index].userJoinStatus != true) {
                      joinContestBloc.add(
                        JoinContestEvent(
                          state.contestModelList![index],
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: screenSize.width * .28,
                    height: screenSize.width * .092,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color:
                          state.contestModelList![index].userJoinStatus == true
                              ? Colors.grey
                              : const Color.fromRGBO(0, 99, 255, 1),
                    ),
                    child: Center(
                      child: Text(
                        state.contestModelList![index].userJoinStatus == true
                            ? 'Joined'
                            : 'Enter Contest',
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .032,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height * .025),
              ],
            );
          },
        ),
      ),
    );
  }
}
