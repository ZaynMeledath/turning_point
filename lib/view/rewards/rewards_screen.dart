import 'package:flutter/material.dart';
import 'package:turning_point/helper/custom_app_bar.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: customAppBar(
                    context: context, screenSize: screenSize, title: 'Rewards'),
                background: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: screenSize.height * .313,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(175, 19, 20, 1),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, -20),
                            blurRadius: 23,
                            color: Color.fromRGBO(175, 0, 2, 1),
                          ),
                          BoxShadow(
                            offset: Offset(0, 25),
                            blurRadius: 123,
                            color: Color.fromRGBO(0, 0, 0, .25),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
