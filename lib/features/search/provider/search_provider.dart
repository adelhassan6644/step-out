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
    selectedCategory = null;
    selectedSubCategory = null;
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
    services?.clear();
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
    notifyListeners();
  }

  onSelectService(i) {
    services![i].isSelected = !services![i].isSelected!;
    if (services![i].isSelected == false) {
      services![i].subServices?.forEach((e) {
        e.isSelected = false;
      });
    }
    notifyListeners();
  }

  onSelectSubService(serviceIndex, subServiceIndex) {
    services![serviceIndex].subServices![subServiceIndex].isSelected =
        !services![serviceIndex].subServices![subServiceIndex].isSelected!;
    notifyListeners();
  }

  clearFilter() {
    range = null;
    selectedCategory = null;
    selectedSubCategory = null;
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

      List<int>? selectedSubServices = [];
      services?.forEach((e) {
        if (e.isSelected! &&
            e.subServices != null &&
            e.subServices!.isNotEmpty) {
          e.subServices?.forEach((i) {
            if (i.isSelected!) {
              selectedSubServices.add(i.id!);
            }
          });
        }
      });

      Map<String, dynamic> filter = {
        if (searchTEC.text.trim().isNotEmpty) "name": searchTEC.text.trim(),
        if (range != null) "range": (range!) * 1000,
        if (selectedCategory != null) "category_id": selectedCategory?.id,
        if (selectedSubCategory != -1 && selectedSubCategory != null)
          "sub_category_id": selectedSubCategory,
        if (services != null && services!.any((e) => e.isSelected!))
          "service_ids": services
              ?.where((e) => e.isSelected!)
              .toList()
              .map((e) => e.id)
              .toList(),
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
