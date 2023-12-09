import 'package:flutter/material.dart';
import 'package:turning_point/view/home/reels_player.dart';

class PageViewer extends StatefulWidget {
  const PageViewer({super.key});

  @override
  State<PageViewer> createState() => PageViewerState();
}

class PageViewerState extends State<PageViewer> {
  late final PageController _pageController;

  final videos = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  ];

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      children: [
        for (int i = 0; i < videos.length; i++) ReelsPlayer(url: videos[i])
      ],
    );
  }
}
