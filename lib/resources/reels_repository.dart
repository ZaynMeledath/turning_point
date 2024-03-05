import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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

  static Future<void> downloadAndSaveVideo(String reel) async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      Directory appDocDir = Directory('');
      // Get the local directory for storing the downloaded video
      if (Platform.isAndroid) {
        appDocDir = Directory("/storage/emulated/0/Download");
      } else {
        appDocDir = await getApplicationDocumentsDirectory();
      }

      String savePath = '${appDocDir.path}/$reel';

      // Download the video using Dio
      await Dio().download('${ApiEndpoints.uploads}/$reel', savePath);
    } catch (e) {
      throw Exception(e);
    }
  }
}
