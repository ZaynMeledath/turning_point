part of 'games_home_screen.dart';

final game = FlappyBirdGame();

class Games {
  static final List<GameModel> gameModelList = [
    GameModel(
      name: 'Flappy Bird',
      thumbnailPath: 'assets/images/flappy_bird_thumbnail.jpg',
      gameWidget: GameWidget(
        game: game,
        initialActiveOverlays: const [MainMenuScreen.id],
        overlayBuilderMap: {
          'mainMenu': (context, _) => MainMenuScreen(game: game),
          'gameOver': (context, _) => GameOverScreen(game: game),
        },
      ),
    ),
  ];
}
