import 'package:flutter/material.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';
import 'package:turning_point/helper/custom_app_bar.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/contest/segments/banner_segment.dart';
import 'package:turning_point/view/contest/segments/contest_card.dart';
import 'package:turning_point/view/contest/segments/contest_heading.dart';

class ContestScreen extends StatefulWidget {
  const ContestScreen({super.key});

  @override
  State<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            customAppBar(context: context, title: 'Contest'),
            bannerSegment(),
            SizedBox(height: screenSize.height * .005),
            Container(
              height: 6,
              color: const Color.fromRGBO(247, 247, 247, 1),
            ),
            SizedBox(height: screenSize.height * .007),
            contestHeading(),
            SizedBox(height: screenSize.height * .007),
            Container(
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: screenSize.width * .051),
              color: const Color.fromRGBO(237, 237, 237, 1),
            ),
            // contestCard(),

            Expanded(
              child: StackedCardCarousel(
                  initialOffset: screenSize.height * .018,
                  spaceBetweenItems: screenSize.height * .32,
                  items: [
                    contestCard(context: context),
                    contestCard(context: context),
                    contestCard(context: context),
                    contestCard(context: context),
                    contestCard(context: context),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
