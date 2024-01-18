import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';

class VideoRepository {
  static List<dynamic> urlList = [];

  static Future<dynamic> getReels() async {
    final decodedResponse = await ApiService().sendRequest(
      url: '${ApiEndpoints.getReelsPaginated}/?page=1&limit=50',
      requestMethod: 'GET',
      data: null,
      isTokenRequired: true,
    );
    final data = decodedResponse['data'];
    final videoNames = data.map((e) => e['fileUrl']).toList();
    urlList = videoNames
        .map((videoName) => '${ApiEndpoints.uploads}/$videoName')
        .toList();

    return urlList;
  }
}
