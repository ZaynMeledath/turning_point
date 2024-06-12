import 'package:flame/game.dart';

class GameModel {
  final String name;
  final String thumbnailPath;
  final GameWidget gameWidget;

  GameModel({
    required this.name,
    required this.thumbnailPath,
    required this.gameWidget,
  });
}
