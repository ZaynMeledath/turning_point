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
}
