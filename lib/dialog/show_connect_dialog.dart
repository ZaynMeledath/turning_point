import 'package:flutter/material.dart';
import 'package:turning_point/helper/screen_size.dart';
// import 'dart:math' as math show pi;

Future<Object?> showConnectDialog({
  required BuildContext context,
}) async {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, a1, a2) {
      return Container();
    },
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, a1, a2, child) {
      final curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        alignment: Alignment.bottomRight,
        scale: curve,
        child: dialog(context),
      );
    },
  );
}

Widget dialog(BuildContext context) {
  return Stack(
    children: [
      GestureDetector(
        onTap: () => Navigator.of(context).pop(true),
        child: Container(
          color: Colors.transparent,
        ),
      ),
      Container(
        margin: EdgeInsets.only(
          left: screenSize.width * .7,
          // right: screenSize.width * .02,
          top: screenSize.height * .8,
          bottom: screenSize.height * .05,
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/icons/phone_icon.png',
              width: screenSize.width * .1,
            ),
            SizedBox(width: screenSize.width * .07),
            Image.asset(
              'assets/icons/whatsapp_icon.png',
              width: screenSize.width * .09,
            ),
          ],
        ),
      ),
    ],
  );
}

// Widget dialog(BuildContext context) {
//   return Stack(
//     children: [
//       GestureDetector(
//         onTap: () => Navigator.of(context).pop(true),
//         child: Container(
//           color: Colors.transparent,
//         ),
//       ),
//       Container(
//         margin: EdgeInsets.only(
//           left: screenSize.width * .071,
//           right: screenSize.width * .071,
//           top: screenSize.height * .72,
//           bottom: screenSize.height * .1,
//         ),
//         padding: EdgeInsets.only(
//           left: screenSize.width * .041,
//           right: screenSize.width * .031,
//           top: screenSize.height * .01,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           // borderRadius: BorderRadius.only(
//           //   topLeft: Radius.circular(16),
//           //   topRight: Radius.circular(16),
//           //   bottomLeft: Radius.circular(16),
//           // ),
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 DefaultTextStyle(
//                   style: GoogleFonts.roboto(
//                     fontSize: screenSize.width * .031,
//                     fontWeight: FontWeight.w500,
//                     color: const Color.fromRGBO(184, 184, 184, 1),
//                   ),
//                   child: const Text('Customer Support'),
//                 ),
//                 GestureDetector(
//                   onTap: () => Navigator.of(context).pop(true),
//                   child: Container(
//                     width: screenSize.width * .061,
//                     height: screenSize.width * .061,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Color.fromRGBO(199, 199, 199, 1),
//                     ),
//                     child: Center(
//                       child: Image.asset(
//                         'assets/icons/connect_close_icon.png',
//                         width: screenSize.width * .024,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: screenSize.height * .01),
//             Row(
//               children: [
//                 Container(
//                   width: screenSize.width * .089,
//                   height: screenSize.width * .089,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color.fromRGBO(236, 236, 236, 1),
//                   ),
//                   child: Center(
//                     child: Image.asset(
//                       'assets/icons/phone_icon.png',
//                       width: screenSize.width * .061,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: screenSize.width * .051),
//                 DefaultTextStyle(
//                   style: GoogleFonts.roboto(
//                     fontSize: screenSize.width * .031,
//                     fontWeight: FontWeight.w500,
//                     color: const Color.fromRGBO(87, 87, 87, 1),
//                   ),
//                   child: const Text('Phone'),
//                 ),
//               ],
//             ),
//             SizedBox(height: screenSize.height * .012),
//             Row(
//               children: [
//                 Container(
//                   width: screenSize.width * .089,
//                   height: screenSize.width * .089,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color.fromRGBO(236, 236, 236, 1),
//                   ),
//                   child: Center(
//                     child: Image.asset(
//                       'assets/icons/whatsapp_icon.png',
//                       width: screenSize.width * .069,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: screenSize.width * .051),
//                 DefaultTextStyle(
//                   style: GoogleFonts.roboto(
//                     fontSize: screenSize.width * .031,
//                     fontWeight: FontWeight.w500,
//                     color: const Color.fromRGBO(87, 87, 87, 1),
//                   ),
//                   child: const Text('WhatsApp'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       Positioned(
//         bottom: screenSize.height * .096,
//         right: screenSize.width * .072,
//         child: Transform.rotate(
//           angle: math.pi / 50,
//           child: ClipPath(
//             clipper: ConnectClipperWidget(),
//             child: Container(
//               width: screenSize.width * .036,
//               height: screenSize.width * .036,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }

//====================Clipper Widget====================//

class ConnectClipperWidget extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width * .5, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
