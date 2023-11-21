import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stepOut/data/error/api_error_handler.dart';
import 'package:stepOut/features/category_details/repo/category_details_repo.dart';
import 'package:stepOut/features/home/models/categories_model.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import '../model/category_details_model.dart';

class CategoryDetailsProvider extends ChangeNotifier {
  CategoryDetailsRepo repo;
  CategoryDetailsProvider({required this.repo});

  int? selectedCategoryId;
  updateCategoryId(id) {
    selectedCategoryId = id;
    selectedServicesId.clear();
    getServices();
    getCategoryDetails();
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
      animatedScrollSubCategories(subCategoriesKeys[i].currentContext!);
      getServices();
      getCategoryDetails();
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
    getCategoryDetails();
  }

  TextEditingController searchTEC = TextEditingController();

  CategoryDetailsModel? model;
  bool isLoading = false;
  getCategoryDetails() async {
    try {
      model = null;
      isLoading = true;
      notifyListeners();
      Map<String, dynamic> filter = {
        "category_id": selectedCategoryId,
        if (selectedSubCategoryId != -1)
          "sub_category_id": selectedSubCategoryId,
        if (selectedServicesId.isNotEmpty) "service_id": selectedServicesId,
      };
      Either<ServerFailure, Response> response = await repo.getCategoryDetails(
          categoryId: selectedCategoryId!, filter: filter);
      response.fold((fail) {
        isLoading = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        model = CategoryDetailsModel.fromJson(success.data);
        isLoading = false;
        notifyListeners();
      });
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

  List<SubCategoryModel>? servicesModel;
  bool isGetServices = false;
  getServices() async {
    try {
      servicesModel?.clear();
      isGetServices = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await repo.getServices(id: selectedSubCategoryId);

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
}
