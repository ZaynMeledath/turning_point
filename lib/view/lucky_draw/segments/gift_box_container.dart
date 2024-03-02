part of '../lucky_draw_screen.dart';

//====================Individual Gift Container Styling====================//
Widget giftBoxContainer() {
  return Container(
    width: screenSize.width * .24,
    height: screenSize.width * .24,
    padding: EdgeInsets.all(screenSize.width * .02),
    decoration: BoxDecoration(
      // color: Colors.white.withOpacity(1),
      gradient: LinearGradient(
        colors: [
          const Color.fromRGBO(255, 221, 84, 1),
          Colors.white.withOpacity(.8),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          offset: Offset(0, 2),
          blurRadius: 4,
          color: Color.fromRGBO(0, 0, 0, .22),
        ),
      ],
    ),
    child: Image.asset('assets/images/red_gift_box.png'),
  );
}
