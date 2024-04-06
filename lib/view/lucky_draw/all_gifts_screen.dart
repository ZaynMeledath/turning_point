part of 'lucky_draw_screen.dart';

class AllGiftsScreen extends StatefulWidget {
  const AllGiftsScreen({super.key});

  @override
  State<AllGiftsScreen> createState() => _AllGiftsScreenState();
}

class _AllGiftsScreenState extends State<AllGiftsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 24, 54, 1),
      //====================App Bar====================//
      appBar: myAppBar(
        context: context,
        title: 'Gifts',
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(19, 24, 54, 1),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
//====================Gifts Segment====================//
            BlocBuilder<LuckyDrawBloc, LuckyDrawState>(
              builder: (context, luckyDrawState) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: 3,
                    left: screenSize.width * .03,
                    right: screenSize.width * .03,
                  ),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: luckyDrawState.contestModel!.prizeArr!.length,
                    itemBuilder: (context, index) {
                      final prizeModel =
                          luckyDrawState.contestModel!.prizeArr![index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: screenSize.width * .05,
                          vertical: screenSize.width * .045,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * .031,
                          vertical: screenSize.width * .025,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(16, 34, 63, 1),
                          // gradient: LinearGradient(
                          //   colors: [
                          //     const Color.fromRGBO(255, 221, 84, 1),
                          //     Colors.white.withOpacity(.8),
                          //   ],
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          // ),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 1,
                              color: Colors.white,
                              blurStyle: BlurStyle.outer,
                            ),
                          ],
                        ),
                        child: ListView(
                          children: [
                            Text(
                              '#${index + 1}',
                              style: GoogleFonts.poppins(
                                fontSize: screenSize.width * .035,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            // index < 6
                            //     ?
                            Image.network(
                              prizeModel.image.toString(),
                              height: screenSize.width * .15,
                            ),
                            // : Image.asset(
                            //     'assets/images/red_gift_box.png',
                            //     height: screenSize.width * .15,
                            //   ),
                            SizedBox(height: screenSize.width * .007),
                            Text(
                              prizeModel.name.toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: screenSize.width * .038,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: screenSize.width * .005),
                            Text(
                              prizeModel.description.toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: screenSize.width * .025,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
