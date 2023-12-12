// SalomonBottomBar(
//         backgroundColor: currentIndex == 0 ? Colors.black : Colors.white,
//         items: [
//           SalomonBottomBarItem(
//             title: const Text('Rewards'),
//             icon: Image.asset(
//               'assets/icons/rewards_icon.png',
//               width: 23,
//               height: 23,
//             ),
//           ),
//           SalomonBottomBarItem(
//             title: const Text('Rewards'),
//             icon: Image.asset(
//               'assets/icons/gift_box_icon.png',
//               width: 23,
//               height: 23,
//             ),
//           ),
//           SalomonBottomBarItem(
//             title: const Text('Rewards'),
//             icon: Image.asset(
//               'assets/icons/scanner_icon.png',
//               width: 23,
//               height: 23,
//             ),
//           ),
//           SalomonBottomBarItem(
//             title: const Text('Rewards'),
//             icon: Image.asset(
//               'assets/icons/phone_icon.png',
//               width: 23,
//               height: 23,
//             ),
//           ),
//           SalomonBottomBarItem(
//             title: const Text('Rewards'),
//             icon: Image.asset(
//               'assets/icons/whatsapp_icon.png',
//               width: 23,
//               height: 23,
//             ),
//           ),
//         ],
//       ),











// CurvedNavigationBar(
//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//         height: 68,
//         color: currentIndex == 0 ? Colors.black : Colors.white,
//         animationDuration: const Duration(milliseconds: 350),
//         backgroundColor: Colors.grey.shade500,
//         buttonBackgroundColor: currentIndex == 0 ? Colors.white : Colors.black,
//         items: [
//           Image.asset(
//             'assets/icons/rewards_icon.png',
//             width: 23,
//             height: 23,
//             color: Colors.black,
//           ),
//           Image.asset(
//             'assets/icons/scanner_icon.png',
//             width: 22,
//             height: 22,
//             color: currentIndex == 0 || currentIndex == 1
//                 ? Colors.white
//                 : Colors.black.withOpacity(.7),
//           ),
//           Image.asset(
//             'assets/icons/gift_box_icon.png',
//             width: 22,
//             height: 22,
//           ),
//           Image.asset(
//             'assets/icons/connect_icon.png',
//             width: 22,
//             height: 22,
//             color: currentIndex == 0 || currentIndex == 3
//                 ? Colors.white
//                 : Colors.black.withOpacity(.7),
//           )
//         ],
//       ),