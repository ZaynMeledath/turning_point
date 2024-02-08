import 'dart:developer';

import 'package:turning_point/model/contest_model.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';

class ContestRepository {
  static Future<ContestModelResponse> getContests() async {
    final response = await ApiService().sendRequest(
      url: ApiEndpoints.getContests,
      requestMethod: 'GET',
      data: null,
      isTokenRequired: true,
    );

    log(response['data'].toString());

    return ContestModelResponse.fromJson(response);
  }

  static List<int> getSecondsLeft(
      {required List<ContestModel> contestModelList}) {
    List<int> secondsLeftList = [];
    for (int i = 0; i < contestModelList.length; i++) {
      // final startDate = contestModelList[i].startDate!.split('T')[0];
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
