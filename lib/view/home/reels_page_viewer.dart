import 'package:flutter/material.dart';
import 'package:turning_point/view/home/reels_player.dart';

class ReelsPageViewer extends StatefulWidget {
  const ReelsPageViewer({super.key});

  @override
  State<ReelsPageViewer> createState() => ReelsPageViewerState();
}

class ReelsPageViewerState extends State<ReelsPageViewer> {
  late final PageController _pageController;

  final videos = [
    'https://assets.mixkit.co/videos/preview/mixkit-curvy-road-on-a-tree-covered-hill-41537-large.mp4',
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
      physics: const BouncingScrollPhysics(),
      children: [
        for (int i = 0; i < videos.length; i++)
          ReelsPlayer(urlList: videos, index: i)
      ],
    );
  }
}
