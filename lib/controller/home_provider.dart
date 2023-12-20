import 'package:turning_point/view/home/reels_screen.dart';
import 'package:turning_point/view/lucky_draw/lucky_draw_screen.dart';
import 'package:turning_point/view/points/points_screen.dart';
import 'package:turning_point/view/rewards/rewards_screen.dart';
import 'package:turning_point/view/scanner_screen.dart';

int currentIndex = 0;

final pages = [
  const ReelsScreen(),
  const RewardsScreen(),
  const ScannerScreen(),
  const LuckyDrawScreen(),
  const PointsScreen(),
];
