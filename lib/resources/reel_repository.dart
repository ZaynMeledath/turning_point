import 'package:turning_point/model/reel_model.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';

class ReelRepository {
  static List<dynamic> urlList = [];

  static Future<ReelModel> getReels() async {
    final response = await ApiService().sendRequest(
      url: '${ApiEndpoints.getReelsPaginated}/?page=1&limit=50',
      requestMethod: 'GET',
      data: null,
      isTokenRequired: true,
    );
    final data = response['data'];
    final videoNames = data.map((e) => e['fileUrl']).toList();
    urlList = videoNames
        .map((videoName) => '${ApiEndpoints.uploads}/$videoName')
        .toList();

    return ReelModel.fromJson(response);
  }

  static Future<bool> getReelLikes() async {
    final reelsModel = await getReels();
    final reelId = reelsModel.data![0].sId;
    final response = await ApiService().sendRequest(
      url: ApiEndpoints.getReelLike,
      requestMethod: 'POST',
      data: {
        "userId": UserRepository.decodeJwt()['userId'],
        "reelId": reelId,
      },
      isTokenRequired: true,
    );

    return response['data']['liked'];
  }
}
