import 'dart:developer';

import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/model/contest_model.dart';
import 'package:turning_point/model/rewards_model.dart';
import 'package:turning_point/service/Exception/api_exception.dart';
import 'package:turning_point/service/Exception/user_exceptions.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';

class ContestRepository {
//====================Get Contests====================//
  static Future<ContestModelResponse> getContests() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.getContestCoupons,
        requestMethod: RequestMethod.GET,
        data: null,
        isTokenRequired: true,
      );

      return ContestModelResponse.fromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }

//====================Join Contest====================//
  static Future<void> joinContest({
    required String id,
    required int entryCount,
  }) async {
    try {
      await ApiService().sendRequest(
        url: '${ApiEndpoints.joinContest}/$id',
        requestMethod: RequestMethod.POST,
        data: {
          'count': entryCount,
        },
        isTokenRequired: true,
      );
    } catch (e) {
      log('EXCEPTION IN JOIN CONTEST METHOD : $e');
      throw CouldNotJoinContestException();
    }
  }

//====================Get Current Contest for Lucky Draw Screen====================//
  static Future<ContestModelResponse> getCurrentContest() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.getCurrentContest,
        requestMethod: RequestMethod.GET,
        data: null,
        isTokenRequired: true,
      );

      return ContestModelResponse.fromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }

//====================Get Current Contest Rewards====================//
  static Future<RewardsModelResponse> getCurrentRewards() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.currentContestRewards,
        requestMethod: RequestMethod.GET,
        data: null,
        isTokenRequired: false,
      );

      return RewardsModelResponse.fromJson(response);
    } on NotFoundException {
      rethrow;
    } catch (e) {
      throw Exception(e);
    }
  }

//====================Get Previous Contest Rewards====================//
  static Future<RewardsModelResponse> getPreviousRewards() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.previousContestRewards,
        requestMethod: RequestMethod.GET,
        data: null,
        isTokenRequired: false,
      );

      return RewardsModelResponse.fromJson(response);
    } on NotFoundException {
      rethrow;
    } catch (e) {
      throw Exception(e);
    }
  }

//====================Get Seconds Left====================//
  static List<int> getSecondsLeft(
      {required List<ContestModel> contestModelList}) {
    List<int> secondsLeftList = [];
    for (int i = 0; i < contestModelList.length; i++) {
      final String endDateString = contestModelList[i].combinedEndDateTime!;
      final DateTime endDate = DateTime.parse(endDateString);
      final currentDateToSecondsSinceEpoch =
          DateTime.now().millisecondsSinceEpoch / 1000;
      final endDateToSecondsSinceEpoch = endDate.millisecondsSinceEpoch / 1000;

      final secondsLeft =
          (endDateToSecondsSinceEpoch - currentDateToSecondsSinceEpoch).toInt();

      final prizeCount = contestModelList[i].prizeArr!.length;

      secondsLeftList
          .add(secondsLeft - (prizeCount * LUCKY_DRAW_WINNER_DISPLAY_DELAY));
    }

    return secondsLeftList;
  }

//====================Get Lucky Draw Seconds Left====================//
  static int getLuckyDrawSecondsLeft({required ContestModel contestModel}) {
    final String endDateString = contestModel.combinedEndDateTime!;
    final DateTime endDate = DateTime.parse(endDateString);

    final currentDateToSecondsSinceEpoch =
        DateTime.now().millisecondsSinceEpoch / 1000;
    final endDateToSecondsSinceEpoch = endDate.millisecondsSinceEpoch / 1000;

    final secondsLeft =
        (endDateToSecondsSinceEpoch - currentDateToSecondsSinceEpoch).toInt();

    // final prizeCount = contestModel.prizeArr!.length;

    // return secondsLeft - (prizeCount * 30);
    return secondsLeft;
  }
}
