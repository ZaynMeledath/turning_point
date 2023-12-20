// void updateTimer() {
//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         seconds++;
//       });
//       print(seconds);
//     });
//   }

//   void resetTimer() {
//     timer?.cancel();
//     print('TIMER CANCELLED');
//   }

//   String formatTime() {
//     setState(() {
//       timeInSeconds = (seconds % 60);
//       timeInMinutes = (seconds ~/ 60);
//       timeInHours = (timeInMinutes ~/ 60);
//     });

//     return '${timeInMinutes.toString().padLeft(2, '0')} : ${timeInSeconds.toString().padLeft(2, '0')}';
//   }