import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class RattingRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  RattingRepo({required this.dioClient, required this.sharedPreferences});

  getUserId() => sharedPreferences.getString(AppStorageKey.userId);

  Future<Position> getCurrentPosition() async {
    await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition(
      forceAndroidLocationManager: true,
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<Either<ServerFailure, Response>> sendRatting(body) async {
    try {
      final position = await getCurrentPosition();

      body.addAll({
        "lat": position.latitude,
        "long": position.longitude,
      });

      Response response =
          await dioClient.post(uri: EndPoints.sendRate, data: body);
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
