import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stepOut/app/core/utils/app_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/api/end_points.dart';
import '../../../data/config/di.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../maps/provider/location_provider.dart';

class SearchRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  SearchRepo({required this.dioClient, required this.sharedPreferences});

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  Future<Position> getCurrentPosition() async {
    await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition(
      forceAndroidLocationManager: true,
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<Either<ServerFailure, Response>> getSearch(filter) async {
    try {
      // final position = await getCurrentPosition();

      filter.addAll({
        "lat": sl<LocationProvider>().currentLocation?.latitude,
        "long": sl<LocationProvider>().currentLocation?.longitude,
      });

      Response response =
          await dioClient.post(uri: EndPoints.searchPlaces, data: filter);

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> getServices(int? id) async {
    try {
      Response response = await dioClient.get(
        uri: id != -1 ? EndPoints.getServices(id) : EndPoints.services,
      );
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
