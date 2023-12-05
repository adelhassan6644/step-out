import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/app/core/utils/app_snack_bar.dart';
import 'package:stepOut/features/home/models/categories_model.dart';
import 'package:stepOut/features/item_details/model/item_details_model.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../../main_models/service_model.dart';
import '../repo/search_repo.dart';

class SearchProvider extends ChangeNotifier {
  final SearchRepo repo;
  SearchProvider({required this.repo});

  bool get isLogin => repo.isLoggedIn();

  final TextEditingController searchTEC = TextEditingController();

  final FocusNode searchNode = FocusNode();
  bool focusOnSearch = false;
  hasFocus() {
    searchNode.addListener(() {
      focusOnSearch = searchNode.hasFocus;
      notifyListeners();
    });
  }

  init() {
    hasFocus();
    searchTEC.clear();
    range = 50;
    selectedCategory = null;
    selectedSubCategory = null;
    selectedServices.clear();
    selectedSubServices.clear();
    services?.clear();
    result.clear();
    notifyListeners();
  }

  clearTEC() {
    searchTEC.clear();
    result.clear();
    notifyListeners();
  }

  double? range;
  onSelectRange(v) {
    range = v;
    notifyListeners();
  }

  CategoryItem? selectedCategory;
  onSelectCategory(CategoryItem? v) {
    if (v?.id == selectedCategory?.id) {
      selectedCategory = null;
    } else {
      selectedCategory = v;
    }
    selectedSubCategory = null;
    selectedServices.clear();
    services?.clear();
    selectedSubServices.clear();

    notifyListeners();
  }

  int? selectedSubCategory;
  onSelectSubCategory(v) {
    if (v == selectedSubCategory) {
      selectedSubCategory = null;
    } else {
      selectedSubCategory = v;
      if (v != -1) {
        getServices(v);
      }
    }
    services?.clear();
    selectedServices.clear();
    selectedSubServices.clear();
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

  clearFilter() {
    range = 50;
    selectedCategory = null;
    selectedSubCategory = null;
    selectedServices.clear();
    selectedSubServices.clear();
    services?.clear();
    getResult();
    notifyListeners();
  }

  List<ServiceModel>? services;
  bool isGetServices = false;
  getServices(id) async {
    try {
      services?.clear();
      isGetServices = true;
      notifyListeners();

      Either<ServerFailure, Response> response = await repo.getServices(id);

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
          services = List<ServiceModel>.from(
            success.data["data"].map(
              (x) => ServiceModel.fromJson(x),
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

  List<ItemDetailsModel> result = [];
  bool isLoading = false;
  getResult() async {
    try {
      isLoading = true;
      result.clear();
      notifyListeners();

      Map<String, dynamic> filter = {
        if (searchTEC.text.trim().isNotEmpty) "name": searchTEC.text.trim(),
        "range": (range ?? 50) * 1000,
        "category_id": selectedCategory?.id,
        if (selectedSubCategory != -1) "sub_category_id": selectedSubCategory,
        if (selectedServices.isNotEmpty) "service_ids": selectedServices,
        if (selectedSubServices.isNotEmpty)
          "sub_service_ids": selectedSubServices,
      };

      Either<ServerFailure, Response> response = await repo.getSearch(filter);
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
