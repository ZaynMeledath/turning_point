part of '../carpenters_list_screen.dart';

Widget carpentersHeaderSegment(BuildContext context) {
  return Container(
    height: screenSize.width * .64,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xff024B9F),
          Color(0xff3D86D9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: customAppBar(
                context: context,
                title: '',
                foregroundColor: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenSize.width * .05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenSize.width * .02),
                  Row(
                    children: [
                      Text(
                        'Carpenters : ',
                        style: GoogleFonts.inter(
                          fontSize: screenSize.width * .04,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      BlocBuilder<CarpenterBloc, CarpenterState>(
                        builder: (context, state) {
                          if (state is CarpenterLoadedState) {
                            return Text(
                              state.carpentersListModel.allCarpenters!.length
                                  .toString(),
                              style: GoogleFonts.inter(
                                fontSize: screenSize.width * .05,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          } else {
                            return Center(
                              child: CupertinoActivityIndicator(
                                radius: screenSize.width * .031,
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.width * .044),
                  Text(
                    'Total Commissions\nEarned',
                    style: GoogleFonts.inter(
                      fontSize: screenSize.width * .04,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenSize.width * .01),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/coin_icon.png',
                        width: screenSize.width * .075,
                      ),
                      BlocBuilder<CarpenterBloc, CarpenterState>(
                        builder: (context, state) {
                          if (state is CarpenterLoadedState) {
                            return Text(
                              state.carpentersListModel.allCarpentersTotal
                                  .toString(),
                              style: GoogleFonts.inter(
                                fontSize: screenSize.width * .06,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          } else {
                            return Center(
                              child: CupertinoActivityIndicator(
                                radius: screenSize.width * .031,
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: -screenSize.width * .22,
          bottom: -screenSize.width * .04,
          child: Container(
            width: screenSize.width * .69,
            height: screenSize.width * .69,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(217, 217, 217, .1),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  blurStyle: BlurStyle.outer,
                  color: Colors.black26,
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: -screenSize.width * .016,
          bottom: screenSize.width * .012,
          child: Image.asset(
            'assets/images/carpenters_screen_illustration.png',
            width: screenSize.width * .44,
          ),
        ),
      ],
    ),
  );
}
