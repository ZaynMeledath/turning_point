import 'dart:developer';

import 'package:turning_point/model/contest_model.dart';
import 'package:turning_point/service/Exception/user_exceptions.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';

class ContestRepository {
//====================Get Contests====================//
  static Future<ContestModelResponse> getContests() async {
    final response = await ApiService().sendRequest(
      url: ApiEndpoints.getContests,
      requestMethod: RequestMethod.GET,
      data: null,
      isTokenRequired: true,
    );

    log('CONTEST RESPONSE: $response');

    return ContestModelResponse.fromJson(response);
  }

//====================Join Contest====================//
  static Future<void> joinContest(String id) async {
    try {
      await ApiService().sendRequest(
        url: '${ApiEndpoints.joinContest}/$id',
        requestMethod: RequestMethod.GET,
        data: null,
        isTokenRequired: true,
      );
    } catch (e) {
      log('EXCEPTION IN JOIN CONTEST METHOD : $e');
      throw CouldNotJoinContestException();
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

      secondsLeftList.add(secondsLeft);
    }

    return secondsLeftList;
  }
}
