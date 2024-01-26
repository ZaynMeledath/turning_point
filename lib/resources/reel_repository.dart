import 'dart:async';
import 'package:turning_point/model/reels_model.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';

class ReelRepository {
  static List<dynamic> urlList = [];
  // static List<Map<String, dynamic>> reelsMap = [];
  static ReelsModel reelsModel = ReelsModel();
  // static StreamController<Map<String, dynamic>> reelsStreamController =
  //     StreamController<Map<String, dynamic>>();

//====================Get Reels Method====================//
  static Future<ReelsModel> getReels() async {
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

    return ReelsModel.fromJson(response);
  }

//====================Like Reel Method====================//
  static Future<bool> likeReel(int index) async {
    final reelsModel = await getReels();
    final reelId = reelsModel.data![index].id;

    final response = await ApiService().sendRequest(
      url: ApiEndpoints.likeReel,
      requestMethod: 'POST',
      data: {
        "userId": UserRepository.decodeJwt()['userId'],
        "reelId": reelId,
      },
      isTokenRequired: true,
    );

    return response['success'];
  }

//====================Get ReelsMap Method====================//
  static Future<void> getReelsModel() async {
    reelsModel = await getReels();
  }
}
