part of '../redeem_screen.dart';

Future<void> _handleRefresh() async {
  await ContestRepository.getContests();
  contestBloc.add(ContestLoadEvent());
}

Widget buyCouponsSegment({
  required BuildContext context,
}) {
  return BlocBuilder<ContestBloc, ContestState>(
    builder: (context, state) {
      if (state is ContestLoadedState) {
        if (state.contestModelList != null &&
            state.contestModelList!.isNotEmpty) {
          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: realScreenSize.width * .05,
                vertical: screenSize.height * .01,
              ),
              itemCount: state.contestModelList!.length,
              itemBuilder: (context, index) {
                return contestListSegment(
                  contestModel: state.contestModelList![index],
                );
              },
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () => _handleRefresh(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * .05),
                  Lottie.asset(
                    'assets/lottie/no_data_animation.json',
                    width: screenSize.width * .4,
                  ),
                  Text(
                    'No Coupons Available at the moment',
                    style: GoogleFonts.inter(
                      fontSize: screenSize.width * .031,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(.75),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      } else {
        return spinningLinesLoading();
      }
    },
  );
}




















// return BlocBuilder<RedeemBloc, RedeemState>(
//   builder: (context, redeemState) {
//     final status = redeemState.isTermsAgreed &&
//         redeemState.redeemPoints <= pointsBloc.state.points!;
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: screenSize.width * .061),
//       child: Column(
//         children: [
//           //====================Coupon Image====================//
//           redeemState is BuyCouponsState && redeemState.coupon != null
//               ? couponCodeContainer(
//                   context: context,
//                   couponCode: redeemState.coupon!,
//                 )
//               : Image.asset(
//                   'assets/images/redeem_screen_gift_voucher.png',
//                   width: screenSize.width * .9,
//                 ),
//           SizedBox(height: screenSize.height * .035),

//           //====================Points Field where points can be changed using + and - buttons====================//
//           redeemPointsFieldSegment(),
//           SizedBox(height: screenSize.height * .025),

//           //====================Amount in Rupees Segment====================//
//           yourAmountSegment(),
//           SizedBox(height: screenSize.height * .025),

//           //====================Agree Terms Segment====================//
//           agreeTermsSegment(),
//           SizedBox(height: screenSize.height * .03),

//           //====================Redeem Button====================//

//           GestureDetector(
//             onTap: () {
//               if (status) {
//                 redeemBloc.add(RedeemButtonPressedEvent());
//               }
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(
//                 horizontal: screenSize.width * .1,
//                 vertical: screenSize.width * .03,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: status
//                     ? const Color.fromRGBO(0, 99, 255, 1)
//                     : Colors.grey,
//               ),
//               child: Text(
//                 'Redeem',
//                 style: GoogleFonts.inter(
//                   fontSize: screenSize.width * .031,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: screenSize.height * .019),
//         ],
//       ),
//     );
//   },
// );
