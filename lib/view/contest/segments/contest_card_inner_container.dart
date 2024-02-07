part of '../contest_screen.dart';

Widget contestCardInnerContainer({
  required BuildContext context,
  required int index,
}) {
  return BlocBuilder<ContestBloc, ContestState>(
    builder: (context, state) {
      switch (state) {
        case ContestLoadingState():
          return Center(
            child: CupertinoActivityIndicator(
              radius: screenSize.width * .036,
              color: Colors.amber,
            ),
          );
        case ContestLoadedState():
          final contestModel = state.contestModelList[index];
          return Container(
            width: double.infinity,
            height: screenSize.height * .216,
            padding: EdgeInsets.only(
              right: screenSize.width * .051,
              top: screenSize.width * .051,
            ),
            decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [
              //     Color.fromRGBO(255, 245, 188, 1),
              // Color.fromRGBO(255, 245, 188, .5),
              //   ],
              // ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(252, 210, 148, 0.6),
                ),
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 1.5,
                  color: Color.fromRGBO(0, 0, 0, .25),
                  blurStyle: BlurStyle.outer,
                ),
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 50,
                  color: Color.fromRGBO(255, 247, 203, 1),
                  blurStyle: BlurStyle.inner,
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * .04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        contestModel.name!,
                        style: GoogleFonts.poppins(
                          fontSize: screenSize.width * .041,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(83, 83, 83, 1),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageTransition(
                              child: ContestDetailsScreen(
                                  contestModel: state.contestModelList[index]),
                              type: PageTransitionType.scale,
                              alignment: Alignment.center,
                              duration: const Duration(milliseconds: 500),
                              reverseDuration:
                                  const Duration(milliseconds: 400),
                            ),
                          );
                        },
                        child: Text(
                          'View Contest Details',
                          style: GoogleFonts.poppins(
                            fontSize: screenSize.width * .028,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromRGBO(83, 83, 83, 1),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenSize.width * .02),
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * .04),
                  child: Row(
                    children: [
                      Text(
                        contestModel.points!.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .076,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(245, 146, 0, 1),
                        ),
                      ),
                      SizedBox(width: screenSize.width * .012),
                      Column(
                        children: [
                          SizedBox(height: screenSize.width * .014),
                          Text(
                            'Points',
                            style: GoogleFonts.roboto(
                              fontSize: screenSize.width * .04,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(26, 26, 26, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenSize.width * .02),
                Text(
                  'Join The Contest and Win Exciting Prizes!',
                  style: GoogleFonts.poppins(
                    fontSize: screenSize.width * .024,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/contest_card_gift_image.png',
                          width: screenSize.width * .28,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: screenSize.width * .31,
                              height: screenSize.width * .092,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color.fromRGBO(0, 99, 255, 1),
                              ),
                              child: Center(
                                child: Text(
                                  'Enter Contest',
                                  style: GoogleFonts.roboto(
                                    fontSize: screenSize.width * .032,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenSize.width * .02)
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );

        default:
          return const Center(child: CupertinoActivityIndicator());
      }
    },
  );
}
