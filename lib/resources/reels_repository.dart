import 'dart:async';
import 'package:turning_point/model/reels_model.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';

class ReelsRepository {
  static List<dynamic> urlList = [];
  // static List<Map<String, dynamic>> reelsMap = [];
  static ReelsModelResponse reelsModelResponse = ReelsModelResponse();
  // static StreamController<Map<String, dynamic>> reelsStreamController =
  //     StreamController<Map<String, dynamic>>();

//====================Get Reels Method====================//
  static Future<ReelsModelResponse> getReels() async {
    final response = await ApiService().sendRequest(
      url: ApiEndpoints.getReelsPaginated,
      requestMethod: RequestMethod.GET,
      data: null,
      isTokenRequired: true,
    );

    // final response = await ApiService().sendRequest(
    //   url: ApiEndpoints.getReels,
    //   requestMethod: FetchMethod.GET,
    //   data: null,
    //   isTokenRequired: false,
    // );

    final data = response['data'];

    final videoNames = data.map((e) => e['fileUrl']).toList();
    urlList = videoNames
        .map((videoName) => '${ApiEndpoints.uploads}/$videoName')
        .toList();

    reelsModelResponse = ReelsModelResponse.fromJson(response);

    return reelsModelResponse;
  }

//====================Like Reel Method====================//
  static Future<bool> likeReel(int index) async {
    final reelsModel = reelsModelResponse;
    final reelId = reelsModel.data![index].id;

    final response = await ApiService().sendRequest(
      url: ApiEndpoints.likeReel,
      requestMethod: RequestMethod.POST,
      data: {
        "userId": UserRepository.decodeJwt()['userId'],
        "reelId": reelId,
      },
      isTokenRequired: true,
    );

    return response['success'];
  }
}