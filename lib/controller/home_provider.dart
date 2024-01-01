import 'package:turning_point/view/connect_screen.dart';
import 'package:turning_point/view/home/reels_screen.dart';
import 'package:turning_point/view/lucky_draw/lucky_draw_screen.dart';
import 'package:turning_point/view/rewards/rewards_screen.dart';
import 'package:turning_point/view/scanner/scanner_screen.dart';

int currentIndex = 0;

final pages = [
  const ReelsScreen(),
  const RewardsScreen(),
  const ScannerScreen(),
  const LuckyDrawScreen(),
  const ConnectScreen(),
];
