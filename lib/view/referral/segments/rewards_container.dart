part of '../referral_screen.dart';

class ReferredScreen extends StatefulWidget {
  const ReferredScreen({super.key});

  @override
  State<ReferredScreen> createState() => _ReferredScreenState();
}

class _ReferredScreenState extends State<ReferredScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 18),

              //---------------Scrath Cards---------------//
              Expanded(
                child: GridView.builder(
                  itemCount: 2,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: GestureDetector(
                      onTap: () => scratchCardPopUp(context),
                      child: Image.asset(
                        'assets/images/star_pattern.png',
                        width: 163,
                        height: 172,
                      ),
                    ),
                  ),
                ),
              ),

              //---------------See Rewards History--------------//
              Container(
                  width: width * .84,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x16000000),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: width * .019),
                      Image.asset(
                        'assets/images/purple_gift_box.png',
                        width: 32,
                        height: 33,
                      ),
                      SizedBox(width: width * .019),
                      Text('See Reward History',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff0054b4),
                          )),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                                EdgeInsets.only(right: screenSize.width * .036),
                            child: const Icon(
                              Icons.keyboard_arrow_right,
                              color: Color(0xff263238),
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}
