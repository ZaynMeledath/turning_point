import 'package:flutter/material.dart';
import 'package:turning_point/utils/widget/custom_app_bar.dart';
import 'package:turning_point/view/games/flappy_bird/game/assets.dart';
import 'package:turning_point/view/games/flappy_bird/game/flappy_bird_game.dart';

class MainMenuScreen extends StatelessWidget {
  final FlappyBirdGame game;
  static const String id = 'mainMenu';

  const MainMenuScreen({
    required this.game,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          game.overlays.remove('mainMenu');
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.menu),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(Assets.message),
              SafeArea(
                child: customAppBar(
                  context: context,
                  title: '',
                  foregroundColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
