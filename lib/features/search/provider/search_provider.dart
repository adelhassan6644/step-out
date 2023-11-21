import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/app_snack_bar.dart';
import 'package:stepOut/features/home/models/categories_model.dart';
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

  List<ItemDetailsModel> result = [];
  int? range;
  onSelectRange(v) {
    range = v;
    notifyListeners();
  }

  CategoryItem? selectedCategory;
  onSelectCategory(v) {
    selectedCategory = v;
    selectedSubCategory = null;
    selectedServices.clear();
    servicesModel?.clear();
    selectedSubServices.clear();
    notifyListeners();
  }

  int? selectedSubCategory;
  onSelectSubCategory(v) {
    selectedSubCategory = v;
    selectedServices.clear();
    servicesModel?.clear();
    selectedSubServices.clear();
    getServices();
    notifyListeners();
  }

  List<int> selectedServices = [];
  onSelectService(id) {
    if (selectedServices.contains(id)) {
      selectedServices.removeWhere((e) => e == id);
    } else {
      selectedServices.add(id);
    }
    notifyListeners();
  }

  List<int> selectedSubServices = [];
  onSelectSubService(id) {
    if (selectedSubServices.contains(id)) {
      selectedSubServices.removeWhere((e) => e == id);
    } else {
      selectedSubServices.add(id);
    }
    notifyListeners();
  }

  clear() {
    searchTEC.clear();
    selectedCategory = null;
    selectedSubCategory = null;
    selectedServices.clear();
    selectedSubServices.clear();
    notifyListeners();
  }

  List<SubCategoryModel>? servicesModel;
  bool isGetServices = false;
  getServices() async {
    try {
      servicesModel?.clear();
      isGetServices = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await repo.getServices(id: selectedSubCategory);

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
          servicesModel = List<SubCategoryModel>.from(
            success.data["data"].map(
              (x) => SubCategoryModel.fromJson(x),
            ),
          );
        },
      );

      isGetServices = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isGetServices = false;
      notifyListeners();
    }
  }

  bool isLoading = false;
  getResult() async {
    try {
      isLoading = true;
      result.clear();
      notifyListeners();

      Map<String, dynamic> body = {
        "keyWords": searchTEC.text.trim(),
        "range": range,
        "category_id": selectedCategory?.id,
        "sub_category_id": selectedSubCategory,
        "service_id": selectedServices,
        "sub_service_id": selectedSubServices,
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
