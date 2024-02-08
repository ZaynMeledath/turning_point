import 'dart:async';
import 'dart:developer';
import 'package:turning_point/model/reels_model.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';

class ReelRepository {
  static List<dynamic> urlList = [];
  // static List<Map<String, dynamic>> reelsMap = [];
  static ReelsModelResponse reelsModelResponse = ReelsModelResponse();
  // static StreamController<Map<String, dynamic>> reelsStreamController =
  //     StreamController<Map<String, dynamic>>();

//====================Get Reels Method====================//
  static Future<ReelsModelResponse> getReels() async {
    final response = await ApiService().sendRequest(
      url: '${ApiEndpoints.getReelsPaginated}/?page=1&limit=6',
      requestMethod: 'GET',
      data: null,
      isTokenRequired: true,
    );

    // final response = await ApiService().sendRequest(
    //   url: ApiEndpoints.getReels,
    //   requestMethod: 'GET',
    //   data: null,
    //   isTokenRequired: false,
    // );

    final data = response['data'];
    log(data.toString());

    final videoNames = data.map((e) => e['fileUrl']).toList();
    urlList = videoNames
        .map((videoName) => '${ApiEndpoints.uploads}/$videoName')
        .toList();

    reelsModelResponse = ReelsModelResponse.fromJson(response);

    return ReelsModelResponse.fromJson(response);
  }

//====================Like Reel Method====================//
  static Future<bool> likeReel(int index) async {
    final reelsModel = reelsModelResponse;
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
}
