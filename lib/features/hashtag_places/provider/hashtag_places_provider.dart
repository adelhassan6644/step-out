import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../item_details/model/item_details_model.dart';
import '../repo/hashtag_places_repo.dart';

class HashtagPlacesProvider extends ChangeNotifier {
  HashtagPlacesRepo repo;
  HashtagPlacesProvider({required this.repo});

  List<ItemDetailsModel>? model;
  bool isLoading = false;
  getPlaces(tagId) async {
    try {
      model?.clear();
      isLoading = true;
      notifyListeners();

      Either<ServerFailure, Response> response = await repo.getPlaces(tagId);
      response.fold(
        (fail) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: ApiErrorHandler.getMessage(fail),
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent));
        },
        (success) {
          model = List<ItemDetailsModel>.from(
            success.data["data"].map(
              (x) => ItemDetailsModel.fromJson(x),
            ),
          );
        },
      );
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }
}
