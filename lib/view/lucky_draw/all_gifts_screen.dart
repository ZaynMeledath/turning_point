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
      backgroundColor: const Color.fromRGBO(255, 204, 0, 1),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
//====================App Bar====================//
            customAppBar(
              context: context,
              title: 'Gifts',
              foregroundColor: Colors.black.withOpacity(.8),
            ),

//====================Background Decoration Circles====================//
            Positioned(
              bottom: -screenSize.width * .82,
              width: screenSize.width * 1.3,
              height: screenSize.width * 1.3,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(226, 181, 54, 1),
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(209, 99, 1, 1),
                      offset: Offset(0, 4),
                      blurRadius: 121,
                      spreadRadius: 4,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -screenSize.width * .7,
              width: screenSize.width * .8,
              height: screenSize.width * .8,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(226, 181, 54, 1),
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(209, 99, 1, .6),
                      offset: Offset(0, 4),
                      blurRadius: 121,
                      spreadRadius: 47,
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                ),
              ),
            ),

//====================Gifts Segment====================//
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * .067),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .045,
                      vertical: screenSize.width * .045,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .031,
                      vertical: screenSize.width * .018,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      // gradient: LinearGradient(
                      //   colors: [
                      //     const Color.fromRGBO(255, 221, 84, 1),
                      //     Colors.white.withOpacity(.9),
                      //   ],
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      // ),
                    ),
                    child: ListView(
                      children: [
                        Image.asset(
                          'assets/images/red_gift_box.png',
                          height: screenSize.width * .15,
                        ),
                        SizedBox(height: screenSize.width * .007),
                        Text(
                          'Gift Name',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .038,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: screenSize.width * .005),
                        Text(
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .025,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
