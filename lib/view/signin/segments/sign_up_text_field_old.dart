// part of '../sign_up_screen.dart';

// Widget signUpTextField({
//   required TextEditingController controller,
//   required String title,
//   required String iconPath,
//   bool? isNumber,
// }) {
//   return Center(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: GoogleFonts.inter(
//             fontSize: screenSize.width * .036,
//             fontWeight: FontWeight.w600,
//             color: Colors.black.withOpacity(.9),
//           ),
//         ),
//         SizedBox(height: screenSize.height * .01),
//         //====================TextField Container====================//
//         Container(
//           width: double.infinity,
//           height: screenSize.height * .058,
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           decoration: BoxDecoration(
//             color: const Color.fromRGBO(246, 246, 246, 1),
//             // color: Colors.white,
//             borderRadius: BorderRadius.circular(8.5),
//             // boxShadow: [
//             //   BoxShadow(
//             //     offset: const Offset(-1.5, 1.5),
//             //     blurRadius: 1.5,
//             //     color: Colors.black.withOpacity(.2),
//             //     blurStyle: BlurStyle.normal,
//             //   ),
//             //   BoxShadow(
//             //     offset: const Offset(1, -.2),
//             //     blurRadius: 1.5,
//             //     color: Colors.black.withOpacity(.2),
//             //     blurStyle: BlurStyle.normal,
//             //   ),
//             // ],
//           ),
//           //====================TextField====================//
//           child: Row(
//             children: [
//               Image.asset(
//                 iconPath,
//                 width: screenSize.width * .04,
//                 color: const Color.fromRGBO(16, 16, 16, .8),
//               ),
//               SizedBox(width: screenSize.width * .031),
//               Flexible(
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                     bottom: screenSize.height * .01,
//                   ),
//                   child: TextFormField(
//                     style: GoogleFonts.roboto(
//                       fontSize: screenSize.width * .036,
//                     ),
//                     controller: controller,
//                     keyboardType:
//                         isNumber == true ? TextInputType.number : null,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'TextFields cannot be blank';
//                       } else {
//                         return null;
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
