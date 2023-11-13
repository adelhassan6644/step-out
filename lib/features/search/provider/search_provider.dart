import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/app_snack_bar.dart';
import 'package:stepOut/features/item_details/model/item_details_model.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../repo/search_repo.dart';

class SearchProvider extends ChangeNotifier {
  final SearchRepo repo;
  SearchProvider({required this.repo});

  bool get isLogin => repo.isLoggedIn();

  final TextEditingController searchTEC = TextEditingController();

  List<ItemDetailsModel> result= [];
  int? range;
  onSelectRange(v) {
    range = v;
    notifyListeners();
  }

  int? categoryId;
  onSelectCategory(v) {
    categoryId = v;
    notifyListeners();
  }

  int? serviceId;
  onSelectService(v) {
    serviceId = v;
    notifyListeners();
  }

  int? subServiceId;
  onSelectSubService(v) {
    subServiceId = v;
    notifyListeners();
  }

  clear() {
    searchTEC.clear();
    categoryId = null;
    serviceId = null;
    subServiceId = null;
    notifyListeners();
  }

  bool isLoading = false;
  getResult(v) async {
    try {
      isLoading = true;
      result.clear();
      notifyListeners();

      Map<String, dynamic> body = {
        "range": range,
        "category_id": categoryId,
        "service_id": serviceId,
        "sub_service_id": subServiceId,
      };

      Either<ServerFailure, Response> response = await repo.getSearch(body);
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.red));
      }, (response) {
        result = List<ItemDetailsModel>.from(
            response.data["data"].map((e) => ItemDetailsModel.fromJson(e)));
      });
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Styles.RED_COLOR,
              isFloating: true));
    }
  }
}
