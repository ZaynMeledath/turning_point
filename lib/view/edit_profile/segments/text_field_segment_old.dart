// return Padding(
//     padding: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
//     child: Center(
//       child: SizedBox(
//         height: screenSize.height * .056 + (screenSize.height * .019) / 2,
//         child: Stack(
//           alignment: Alignment.bottomCenter,
//           children: [
// //====================TextField Container====================//
//             Container(
//               width: double.infinity,
//               height: screenSize.height * .056,
//               padding: const EdgeInsets.only(left: 15, right: 15),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   width: 1,
//                   color: const Color.fromRGBO(142, 142, 142, 1),
//                 ),
//               ),
// //====================TextField and Pencil Icon====================//
//               child: Row(
//                 children: [
//                   Flexible(
//                     child: TextFormField(
//                       controller: controller,
//                       textAlignVertical: TextAlignVertical.center,
//                       keyboardType:
//                           isNumber == true ? TextInputType.number : null,
//                       style: GoogleFonts.roboto(
//                         letterSpacing: 1,
//                         fontSize: screenSize.height * .017,
//                         color: const Color.fromRGBO(16, 16, 16, 1),
//                       ),
//                       decoration: const InputDecoration(
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   Image.asset(
//                     'assets/icons/pencil_icon.png',
//                     width: screenSize.width * .051,
//                     height: screenSize.width * .051,
//                   ),
//                 ],
//               ),
//             ),
// //====================floating TextField Title====================//
//             Positioned(
//               top: 0,
//               left: screenSize.width * .05,
//               child: Container(
//                 height: screenSize.height * .019,
//                 padding:
//                     EdgeInsets.symmetric(horizontal: screenSize.width * .028),
//                 color: Colors.white,
//                 child: Center(
//                   child: Text(
//                     title,
//                     style: GoogleFonts.inter(
//                       fontSize: screenSize.width * .028,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );