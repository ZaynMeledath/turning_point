import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:turning_point/service/Exception/scanner_exceptions.dart';
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

  static Future<Position> sendLocationToServer() async {
    try {
      final locationData = await getCurrentLocation();
      log('LOCATION: ${locationData.latitude}, ${locationData.longitude}');
      await ApiService().sendRequest(
        url: ApiEndpoints.monitorLocation,
        requestMethod: RequestMethod.PATCH,
        data: {
          'coordinates': [
            locationData.latitude,
            locationData.longitude,
          ],
        },
        isTokenRequired: true,
      );
      return locationData;
    } catch (_) {
      throw LocationServiceException();
    }
  }

  static Future<Position?> getLocationInBackground() async {
    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    } else {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    }
  }

  static const fetchBackground = "fetchBackground";
  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      switch (task) {
        case fetchBackground:
          Position? locationData =
              await LocationRepository.getLocationInBackground();
          if (locationData != null) {
            await ApiService().sendRequest(
              url: ApiEndpoints.monitorLocation,
              requestMethod: RequestMethod.PATCH,
              data: {
                "coordinates": [
                  locationData.latitude,
                  locationData.longitude,
                ],
              },
              isTokenRequired: true,
            );
          }

          break;
      }
      return Future.value(true);
    });
  }
}



  // static final location = Location();

  // static Future<LocationData?> getCurrentLocation() async {
  //   try {
  //     bool serviceEnabled = await location.serviceEnabled();
  //     if (!serviceEnabled) {
  //       serviceEnabled = await location.requestService();
  //       if (!serviceEnabled) {
  //         return null;
  //       }
  //     }

  //     PermissionStatus permissionGranted = await location.hasPermission();
  //     if (permissionGranted == PermissionStatus.denied) {
  //       permissionGranted = await location.requestPermission();
  //       if (permissionGranted != PermissionStatus.granted) {
  //         return null;
  //       }
  //     }
  //     final locationData = await location.getLocation();
  //     await location.enableBackgroundMode(enable: true);
  //     await location.changeSettings(interval: 600000);
  //     location.onLocationChanged.listen((LocationData currentLocation) async {
  //       await ApiService().sendRequest(
  //         url: ApiEndpoints.monitorLocation,
  //         requestMethod: RequestMethod.POST,
  //         data: {
  //           'latitude': currentLocation.latitude,
  //           'longitude': currentLocation.longitude,
  //         },
  //         isTokenRequired: true,
  //       );
  //     });
  //     return locationData;
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }