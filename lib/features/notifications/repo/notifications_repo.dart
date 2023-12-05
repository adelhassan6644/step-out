import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class NotificationsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  NotificationsRepo({required this.dioClient, required this.sharedPreferences});

  String get userId => sharedPreferences.getString(AppStorageKey.userId) ?? "";

  bool get isLogin => sharedPreferences.containsKey(AppStorageKey.isLogin);

  bool get isTurnOn => sharedPreferences.containsKey(AppStorageKey.isSubscribe);

  Future switchNotification() async {
    if (isTurnOn) {
      await FirebaseMessaging.instance
          .unsubscribeFromTopic(userId)
          .then((v) async {
        await sharedPreferences.remove(AppStorageKey.isSubscribe);
      });
    } else {
      await FirebaseMessaging.instance.subscribeToTopic(userId).then((v) async {
        await sharedPreferences.setBool(AppStorageKey.isSubscribe, true);
      });
    }
  }

  Future<Either<ServerFailure, Response>> getNotifications() async {
    try {
      Response response =
          await dioClient.get(uri: EndPoints.getNotifications(userId));
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> readNotification(id) async {
    try {
      Response response =
          await dioClient.post(uri: EndPoints.readNotification(userId, id));
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> deleteNotification(id) async {
    try {
      Response response =
          await dioClient.post(uri: EndPoints.deleteNotification(userId, id));
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
