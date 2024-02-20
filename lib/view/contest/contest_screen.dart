import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';
import 'package:turning_point/bloc/contest/contest_bloc.dart';
import 'package:turning_point/bloc/contest/join_contest_bloc.dart';
import 'package:turning_point/dialog/show_generic_dialog.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/model/contest_model.dart';
import 'package:turning_point/service/Exception/user_exceptions.dart';
import 'package:turning_point/view/contest/segments/banner_segment.dart';

part 'segments/contest_card_inner_container.dart';
part 'segments/contest_card.dart';
part 'segments/contest_count_down_container.dart';
part 'contest_details_screen.dart';
part 'segments/contest_heading.dart';

class ContestScreen extends StatefulWidget {
  const ContestScreen({super.key});

  @override
  State<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen> {
  @override
  void dispose() async {
    super.dispose();
    contestBloc.add(ContestTimerDisposeEvent());
  }

  @override
  Widget build(BuildContext context) {
    contestBloc.add(ContestLoadEvent());
    return BlocListener<JoinContestBloc, JoinContestState>(
      listener: (context, state) {
        if (state is JoinContestErrorState) {
          switch (state.exception) {
            case InsufficientBalanceToJoinContestException():
              showGenericDialog(
                context: context,
                title: 'Error',
                content: 'Insufficient Balance to join the contest',
                options: {'Dismiss': null},
              );
              break;
            default:
              showGenericDialog(
                context: context,
                title: 'Error',
                content: 'Something Went Wrong',
                options: {'Dismiss': null},
              );
          }
        }
      },
      child: Scaffold(
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
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width * .051),
                color: const Color.fromRGBO(237, 237, 237, 1),
              ),
              BlocBuilder<ContestBloc, ContestState>(
                builder: (context, state) {
                  switch (state) {
                    case ContestLoadingState():
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(height: screenSize.height * .1),
                            const CircularProgressIndicator.adaptive(
                              strokeWidth: 5,
                              backgroundColor: Colors.white,
                              valueColor: AlwaysStoppedAnimation(Colors.amber),
                            ),
                          ],
                        ),
                      );
                    case ContestLoadedState():
                      if (state.contestModelList != null &&
                          state.contestModelList!.isNotEmpty) {
                        return Expanded(
                          child: StackedCardCarousel(
                            initialOffset: screenSize.height * .018,
                            spaceBetweenItems: screenSize.height * .32,
                            items: [
                              for (int i = 0;
                                  i < state.contestModelList!.length;
                                  i++)
                                contestCard(context: context, index: i),
                            ],
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }

                    default:
                      return const Center(
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 5,
                          backgroundColor: Colors.white,
                          valueColor: AlwaysStoppedAnimation(Colors.amber),
                        ),
                      );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
