import 'dart:async';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/model/game_model.dart';
import 'package:turning_point/utils/custom_navigator.dart';
import 'package:turning_point/utils/screen_size.dart';
import 'package:turning_point/utils/widget/custom_app_bar.dart';
import 'package:turning_point/view/games/flappy_bird/game/flappy_bird_game.dart';
import 'package:turning_point/view/games/flappy_bird/screens/game_over_screen.dart';
import 'package:turning_point/view/games/flappy_bird/screens/main_menu_screen.dart';

part 'game_grid.dart';
part 'games.dart';

class GamesHomeScreen extends StatefulWidget {
  const GamesHomeScreen({super.key});

  @override
  State<GamesHomeScreen> createState() => _GamesHomeScreenState();
}

class _GamesHomeScreenState extends State<GamesHomeScreen> {
  bool animateText = false;

  @override
  void initState() {
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        animateText = !animateText;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: screenSize.width * .6,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/play_and_earn_banner.jpg',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SafeArea(
                  child: AnimatedScale(
                    scale: animateText ? .97 : 1,
                    duration: const Duration(milliseconds: 1000),
                    child: Image.asset(
                      'assets/images/play_and_earn_text.png',
                      width: screenSize.width * .8,
                    ),
                  ),
                ),
                SafeArea(
                  child: customAppBar(
                    context: context,
                    title: '',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: Games.gameModelList.length,
              padding: EdgeInsets.only(
                left: screenSize.width * .07,
                right: screenSize.width * .07,
                top: screenSize.height * .025,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: screenSize.width * .1,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: screenSize.height * .025),
                  child: gameGrid(
                    gameIndex: index,
                    context: context,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
