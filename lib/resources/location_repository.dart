import 'package:geolocator/geolocator.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';
import 'package:workmanager/workmanager.dart';

//====================Get Current Location Method====================//
class LocationRepository {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}

const fetchBackground = "fetchBackground";
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackground:
        Position userLocation = await LocationRepository.getCurrentLocation();
        await ApiService().sendRequest(
          url: ApiEndpoints.gpsData,
          requestMethod: RequestMethod.POST,
          data: {
            'latitude': userLocation.latitude,
            'longitude': userLocation.longitude,
          },
          isTokenRequired: false,
        );
        break;
    }
    return Future.value(true);
  });
}
