import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:stepOut/data/error/api_error_handler.dart';
import 'package:stepOut/features/category_details/repo/category_details_repo.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import '../model/category_details_model.dart';

class CategoryDetailsProvider extends ChangeNotifier {
  CategoryDetailsRepo repo;
  CategoryDetailsProvider({required this.repo});

  AutoScrollController controller1 = AutoScrollController();

  List<String> subCategories = [
    "All",
    "BreakFast",
    "Lunch",
    "Dinner",
    "Fast Food",
    "Burger"
  ];

  int selectedSubCategory = 0;
  onSelectSubCategory(i) {
    selectedSubCategory = i;
    controller1.scrollToIndex(
      i,
      preferPosition: AutoScrollPosition.end,
      duration: const Duration(milliseconds: 800),
    );
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
