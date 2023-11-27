import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class CategoryDetailsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  CategoryDetailsRepo(
      {required this.dioClient, required this.sharedPreferences});

  Future<Position> getCurrentPosition() async {
    await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition(
      forceAndroidLocationManager: true,
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<Either<ServerFailure, Response>> getPlaces(
      {required int categoryId, required Map<String, dynamic> filter}) async {
    try {
      final position = await getCurrentPosition();

      filter.addAll({
        "lat": position.latitude,
        "long": position.longitude,
      });

      Response response = await dioClient.get(
          uri: EndPoints.getCategoryDetails(categoryId),
          queryParameters: filter);
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> getServices({int? id}) async {
    try {
      Response response = await dioClient.get(
          uri: EndPoints.services,
          queryParameters: {if (id != null) "sub_category_id": id});
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
