import 'package:turning_point/model/points_history_model.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';

class PointsHistoryRespository {
  static Future<PointsHistoryModelResponse> getPointsHistory() async {
    final userId = UserRepository.getUserFromPreference()!.data!.id;
    final response = await ApiService().sendRequest(
      url: '${ApiEndpoints.pointsHistory}?userId=$userId',
      requestMethod: RequestMethod.GET,
      data: null,
      isTokenRequired: true,
    );
    return PointsHistoryModelResponse.fromJson(response);
  }
}
