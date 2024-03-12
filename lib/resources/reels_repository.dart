import 'dart:async';
import 'dart:developer';
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

  static int reelDownloadProgress = 0;
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

    urlList = data.map((e) => e['fileUrl']).toList();
    log(urlList.toString());
    // final videoNames = data.map((e) => e['fileUrl']).toList();
    // urlList = videoNames
    //     .map((videoName) => '${ApiEndpoints.uploads}/$videoName')
    //     .toList();

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

  static Future<void> downloadAndSaveVideo(String reelUrl) async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      // Get the local directory for storing the downloaded video
      Directory appDocDir = Directory('');
      if (Platform.isAndroid) {
        appDocDir = Directory("/storage/emulated/0/Download");
      } else {
        appDocDir = await getApplicationDocumentsDirectory();
      }

      String savePath =
          '${appDocDir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';

      // Download the video using Dio
      await Dio().download(
        reelUrl,
        savePath,
        onReceiveProgress: (count, total) {
          reelDownloadProgress = (count / total * 100).toInt();
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  // static Future<String> createFolderInAppDocDir(String folderName) async {
  //   //Get this App Document Directory
  //   Directory appDocDir = Directory('');
  //   if (Platform.isAndroid) {
  //     appDocDir = Directory("/storage/emulated/0/Download");
  //   } else {
  //     appDocDir = await getApplicationDocumentsDirectory();
  //   }
  //   //App Document Directory + folder name
  //   final Directory appDocDirFolder =
  //       Directory('${appDocDir.path}/$folderName/');

  //   if (await appDocDirFolder.exists()) {
  //     //if folder already exists return path
  //     return appDocDirFolder.path;
  //   } else {
  //     //if folder not exists create folder and then return its path
  //     final Directory appDocDirNewFolder =
  //         await appDocDirFolder.create(recursive: true);
  //     return appDocDirNewFolder.path;
  //   }
  // }
}
