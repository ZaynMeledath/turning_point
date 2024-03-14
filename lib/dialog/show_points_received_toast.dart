import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

showPointsReceivedToast({
  required BuildContext context,
  required int points,
}) {
  final flutterToast = FToast();
  flutterToast.init(context);

  flutterToast.showToast(
    fadeDuration: const Duration(milliseconds: 200),
    gravity: ToastGravity.TOP,
    child: dialog(points: points),
    positionedToastBuilder: (context, child) {
      return Positioned(
        top: screenSize.height * .066,
        left: screenSize.width * .305,
        child: child,
      );
    },
  );
}

Widget dialog({
  required int points,
}) {
  return Container(
    width: screenSize.width * .48,
    padding: EdgeInsets.symmetric(vertical: screenSize.width * .015),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      children: [
        SizedBox(width: screenSize.width * .02),
        Image.asset(
          'assets/images/points_received_dialog_image.png',
          width: screenSize.width * .07,
        ),
        SizedBox(width: screenSize.width * .02),
        DefaultTextStyle(
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .04,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          child: Text(
            '$points Points Credited',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}




















// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:turning_point/helper/screen_size.dart';

// Future<Object?> showPointsReceivedToast({
//   required BuildContext context,
//   required int points,
// }) async {
//   return showGeneralDialog(
//     barrierColor: Colors.transparent,
//     context: context,
//     pageBuilder: (context, a1, a2) {
//       return Container();
//     },
//     transitionDuration: const Duration(milliseconds: 300),
//     transitionBuilder: (context, a1, a2, child) {
//       final curve = Curves.easeInOut.transform(a1.value);
//       return Transform.scale(
//         alignment: Alignment.topCenter,
//         scale: curve,
//         child: dialog(
//           context: context,
//           points: points,
//         ),
//       );
//     },
//   );
// }

// Widget dialog({
//   required BuildContext context,
//   required int points,
// }) {
//   return Container(
//     margin: EdgeInsets.only(
//       left: screenSize.width * .28,
//       right: screenSize.width * .27,
//       top: screenSize.height * .07,
//       bottom: screenSize.height * .89,
//     ),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(15),
//     ),
//     child: Row(
//       children: [
//         SizedBox(width: screenSize.width * .017),
//         Image.asset(
//           'assets/images/points_received_dialog_image.png',
//           width: screenSize.width * .07,
//         ),
//         SizedBox(width: screenSize.width * .015),
//         DefaultTextStyle(
//           style: GoogleFonts.roboto(
//             fontSize: screenSize.width * .04,
//             fontWeight: FontWeight.w400,
//             color: Colors.black,
//           ),
//           child: Text(
//             '$points Points Credited',
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ],
//     ),
//   );
// }
