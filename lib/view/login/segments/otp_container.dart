// part of 'package:turning_point/view/login/otp_verfication_screen.dart';

// Widget otpContainer({
//   required TextEditingController controller,
//   required FocusNode focusNode,
// }) {
//   return Container(
//     width: screenSize.width * .09,
//     height: screenSize.width * .09,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(4),
//       border: Border.all(
//         color: focusNode.hasFocus
//             ? Colors.blue
//             : const Color.fromRGBO(155, 155, 155, 1),
//       ),
//     ),
//     child: TextField(
//       controller: controller,
//       focusNode: focusNode,
//       autofocus: true,
//       showCursor: false,
//       maxLength: 1,
//       keyboardType: TextInputType.number,
//       textAlign: TextAlign.center,
//       decoration: const InputDecoration(
//         border: InputBorder.none,
//         counterText: '',
//       ),
//       onChanged: (value) {
//         focusNode.nextFocus();
//       },
//     ),
//   );
// }
