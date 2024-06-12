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
  static int reelsPageSize = 0;
  static ReelsModelResponse reelsModelResponse = ReelsModelResponse();

  static int reelDownloadProgress = 0;

  static CancelToken cancelToken = CancelToken();

//====================Get Reels Method====================//
  static Future<ReelsModelResponse> getReels({required int page}) async {
    try {
      final response = await ApiService().sendRequest(
        url: '${ApiEndpoints.getReelsPaginated}?page=$page',
        requestMethod: RequestMethod.GET,
        data: null,
        isTokenRequired: true,
      );

      final data = response['data'];

      reelsPageSize = data.length;

      if (page == 1) {
        urlList = data.map((e) => e['fileUrl']).toList();
        reelsModelResponse = ReelsModelResponse.fromJson(response);
      } else {
        urlList.addAll(data.map((e) => e['fileUrl']).toList());
        final tempReelsModelResponse = ReelsModelResponse.fromJson(response);
        reelsModelResponse.data!.addAll(tempReelsModelResponse.data!);
      }

      return reelsModelResponse;
    } catch (e) {
      log('EXCEPTION IN GET REELS : $e');
      throw Exception(e);
    }
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

//====================Download and Save Video Method====================//
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
          '${appDocDir.path}/TurningPoint-${DateTime.now().millisecondsSinceEpoch}.mp4';

      // Download the video using Dio
      await Dio().download(
        reelUrl,
        savePath,
        onReceiveProgress: (count, total) {
          reelDownloadProgress = (count / total * 100).toInt();
        },
        cancelToken: cancelToken,
      );
    } catch (e) {
      cancelToken.cancel();
    }
  }

//====================Pause Reel Download Method====================//
  static void pauseReelDownload() {
    cancelToken.cancel();
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
