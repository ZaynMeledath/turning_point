import 'dart:developer';

import 'package:location/location.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';

//====================Get Current Location Method====================//
class LocationRepository {
  // static Future<Position> getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   return await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }

  static final location = Location();

  static Future<LocationData?> getCurrentLocation() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return null;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }
      final locationData = await location.getLocation();
      await location.enableBackgroundMode(enable: true);
      await location.changeSettings(interval: 10000);
      location.onLocationChanged.listen((LocationData currentLocation) async {
        log('############BACKGROUND LOCATION EXECUTED###########');
        await ApiService().sendRequest(
          url: ApiEndpoints.monitorLocation,
          requestMethod: RequestMethod.POST,
          data: {
            'latitude': currentLocation.latitude,
            'longitude': currentLocation.longitude,
          },
          isTokenRequired: false,
        );
      });
      return locationData;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> sendLocationToServer() async {
    final locationData = await getCurrentLocation();
    if (locationData != null) {
      await ApiService().sendRequest(
        url: ApiEndpoints.monitorLocation,
        requestMethod: RequestMethod.POST,
        data: {
          'latitude': locationData.latitude,
          'longitude': locationData.longitude,
        },
        isTokenRequired: false,
      );
    }
  }

//   static Future<Position?> getLocationInBackground() async {
//     final permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       return null;
//     } else {
//       return await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//     }
//   }
}

// const fetchBackground = "fetchBackground";
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     switch (task) {
//       case fetchBackground:
//         Position? userLocation =
//             await LocationRepository.getLocationInBackground();
//         if (userLocation != null) {
//           await ApiService().sendRequest(
//             url: ApiEndpoints.monitorLocation,
//             requestMethod: RequestMethod.POST,
//             data: {
//               'latitude': userLocation.latitude,
//               'longitude': userLocation.longitude,
//             },
//             isTokenRequired: false,
//           );
//         }

//         break;
//     }
//     return Future.value(true);
//   });
// }
