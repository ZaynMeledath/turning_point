import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/bloc/carpenter/carpenter_bloc.dart';
import 'package:turning_point/utils/screen_size.dart';
import 'package:turning_point/utils/widget/custom_app_bar.dart';
import 'package:turning_point/model/carpenters_list_model.dart';

part 'segments/carpenters_header_segment.dart';
part 'segments/carpenter_card.dart';

class CarpentersListScreen extends StatefulWidget {
  const CarpentersListScreen({super.key});

  @override
  State<CarpentersListScreen> createState() => _CarpentersListScreenState();
}

class _CarpentersListScreenState extends State<CarpentersListScreen> {
  @override
  Widget build(BuildContext context) {
    carpenterBloc.add(CarpenterLoadEvent());
    return Scaffold(
      body: Column(
        children: [
          carpentersHeaderSegment(context),
          Expanded(
            child: BlocBuilder<CarpenterBloc, CarpenterState>(
              builder: (context, state) {
                switch (state) {
                  case CarpenterInitialState():
                    return const SizedBox();
                  case CarpenterLoadingState():
                    return Column(
                      children: [
                        SizedBox(height: screenSize.height * .15),
                        const SpinKitSpinningLines(
                          color: Colors.amber,
                          size: 60,
                        ),
                      ],
                    );
                  case CarpenterLoadErrorState():
                    return LiquidPullToRefresh(
                      height: 60,
                      animSpeedFactor: 2,
                      showChildOpacityTransition: false,
                      color: const Color.fromRGBO(89, 165, 255, 1),
                      backgroundColor: Colors.white,
                      onRefresh: () => _handleRefresh(),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: screenSize.height * .15),
                              Lottie.asset(
                                'assets/lottie/no_internet_animation.json',
                                width: screenSize.width * .5,
                              ),
                              Text(
                                'Something Went Wrong',
                                style: GoogleFonts.inter(
                                  fontSize: screenSize.width * .038,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  case CarpenterLoadedState():
                    if (state.carpentersListModel.allCarpenters!.isEmpty) {
                      return LiquidPullToRefresh(
                        height: 60,
                        animSpeedFactor: 2,
                        showChildOpacityTransition: false,
                        color: const Color.fromRGBO(89, 165, 255, 1),
                        backgroundColor: Colors.white,
                        onRefresh: () => _handleRefresh(),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(height: screenSize.height * .15),
                                Lottie.asset(
                                  'assets/lottie/no_data_animation.json',
                                  width: screenSize.width * .5,
                                ),
                                Text(
                                  'No Carpenters Available',
                                  style: GoogleFonts.inter(
                                    fontSize: screenSize.width * .038,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(.75),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        color: const Color.fromRGBO(20, 94, 180, .05),
                        child: Center(
                          child: LiquidPullToRefresh(
                            height: 50,
                            animSpeedFactor: 2,
                            showChildOpacityTransition: false,
                            color: const Color.fromRGBO(89, 165, 255, 1),
                            backgroundColor: Colors.white,
                            onRefresh: () => _handleRefresh(),
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                top: screenSize.width * .05,
                                left: screenSize.width * .04,
                                right: screenSize.width * .04,
                              ),
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return carpenterCard(
                                  carpenterModel: state.carpentersListModel
                                      .allCarpenters![index],
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRefresh() async {}
}
