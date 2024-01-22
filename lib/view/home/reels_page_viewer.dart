import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/resources/reel_repository.dart';
import 'package:turning_point/view/home/reels_player.dart';

class ReelsPageViewer extends StatefulWidget {
  const ReelsPageViewer({super.key});

  @override
  State<ReelsPageViewer> createState() => ReelsPageViewerState();
}

class ReelsPageViewerState extends State<ReelsPageViewer> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<PreloadBloc>()
        .add(PreloadEvent(currentIndex: 0, isInitial: true));
    setState(() {});
    return BlocBuilder<PreloadBloc, PreloadState>(
      builder: (context, state) {
        return PageView.builder(
          itemCount: ReelRepository.urlList.length,
          itemBuilder: (context, index) {
            return ReelsPlayer(videoController: state.controllers[index]!);
          },
          onPageChanged: (index) {
            context
                .read<PreloadBloc>()
                .add(PreloadEvent(currentIndex: index, isInitial: false));
          },
          scrollDirection: Axis.vertical,
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
        );
      },
    );
  }
}
