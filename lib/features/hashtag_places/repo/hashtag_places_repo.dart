import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/api/end_points.dart';
import '../../../data/config/di.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../maps/provider/location_provider.dart';

class HashtagPlacesRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  HashtagPlacesRepo({required this.dioClient, required this.sharedPreferences});

  Future<Position> getCurrentPosition() async {
    await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition(
      forceAndroidLocationManager: true,
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<Either<ServerFailure, Response>> getPlaces(tagId) async {
    try {
      Response response =
          await dioClient.post(uri: EndPoints.getTagPlaces(tagId), data: {
        "lat": sl<LocationProvider>().currentLocation?.latitude,
        "long": sl<LocationProvider>().currentLocation?.longitude,
      });
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }
}
