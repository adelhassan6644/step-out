import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stepOut/data/error/api_error_handler.dart';
import 'package:stepOut/features/category_details/repo/category_details_repo.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import '../../../main_models/service_model.dart';
import '../../item_details/model/item_details_model.dart';

class CategoryDetailsProvider extends ChangeNotifier {
  CategoryDetailsRepo repo;
  CategoryDetailsProvider({required this.repo});
  TextEditingController searchTEC = TextEditingController();

  int? selectedCategoryId;
  init(id) {
    selectedCategoryId = id;
    selectedSubCategoryId = -1;
    selectedSubCategoryIndex = 0;
    animatedScrollSubCategories(subCategoriesKeys[0].currentContext!);
    selectedServicesId.clear();
    services?.clear();
    getServices(selectedSubCategoryId);
    getPlaces();
    notifyListeners();
  }

  bool goingDown = false;
  scroll(controller) {
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        goingDown = false;
      } else {
        goingDown = true;
      }
      notifyListeners();
    });
  }

  final List<GlobalKey> subCategoriesKeys = [];
  animatedScrollSubCategories(BuildContext context) {
    Scrollable.ensureVisible(context,
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
        alignment: 0.5);
  }

  int? selectedSubCategoryId;
  int selectedSubCategoryIndex = 0;
  onSelectSubCategory(i, id) {
    if (id != selectedSubCategoryId) {
      selectedSubCategoryId = id;
      selectedSubCategoryIndex = i;
      selectedServicesId.clear();
      services?.clear();
      animatedScrollSubCategories(subCategoriesKeys[i].currentContext!);
      getServices(id);
      getPlaces();
    }
    notifyListeners();
  }

  List<int> selectedServicesId = [];
  onSelectService(id) {
    if (selectedServicesId.contains(id)) {
      selectedServicesId.removeWhere((e) => e == id);
    } else {
      selectedServicesId.add(id);
    }
    notifyListeners();
    getPlaces();
  }

  List<ItemDetailsModel>? model;
  bool isLoading = false;
  getPlaces() async {
    try {
      model?.clear();
      isLoading = true;
      notifyListeners();
      Map<String, dynamic> filter = {
        "category_id": selectedCategoryId,
        if (selectedSubCategoryId != -1)
          "sub_category_id": selectedSubCategoryId,
        if (selectedServicesId.isNotEmpty)
          "service_ids": selectedServicesId.toList(),
      };

      Either<ServerFailure, Response> response =
          await repo.getPlaces(filter: filter);
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
}
