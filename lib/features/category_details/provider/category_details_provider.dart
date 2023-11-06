import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stepOut/data/error/api_error_handler.dart';
import 'package:stepOut/features/category_details/repo/category_details_repo.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import '../model/category_details_model.dart';

class CategoryDetailsProvider extends ChangeNotifier {
  CategoryDetailsRepo repo;
  CategoryDetailsProvider({required this.repo});

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

  List<String> subCategories = [
    "All",
    "BreakFast",
    "Lunch",
    "Dinner",
    "Fast Food",
    "Burger"
  ];

  final List<GlobalKey> subCategoriesKeys = [];
  animatedScrollSubCategories(BuildContext context) {
    Scrollable.ensureVisible(context,
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
        alignment: 0.5);
  }

  int selectedSubCategory = 0;
  onSelectSubCategory(i) {
    selectedSubCategory = i;
    animatedScrollServices(subCategoriesKeys[i].currentContext!);
    notifyListeners();
  }

  final List<GlobalKey> servicesKeys = [];
  animatedScrollServices(BuildContext context) {
    Scrollable.ensureVisible(context,
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
        alignment: 0.5);
  }

  int selectedFilter = 0;
  onSelectFilter(i) {
    selectedFilter = i;
    animatedScrollServices(servicesKeys[i].currentContext!);
    notifyListeners();
  }

  List<String> filters = [
    "Smoking",
    "Non-Smoking",
    "Kids Area",
    "Swimming Pool",
    "Sea View",
    "Mol"
  ];

  TextEditingController searchTEC = TextEditingController();

  CategoryDetailsModel? model;
  bool isLoading = false;
  getCategoryDetails(id) async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await repo.getCategoryDetails(id);
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
}
