import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import '../model/item_details_model.dart';
import '../repo/item_details_repo.dart';

class ItemDetailsProvider extends ChangeNotifier {
  ItemDetailsRepo repo;
  ItemDetailsProvider({required this.repo});

  int selectedTab = 0;
  onSelectTab(i) {
    selectedTab = i;
    notifyListeners();
  }

  List<String> tabs = ["information", "images", "feedback"];

  List<String> services = [
    "information",
    "images",
    "feedback",
    "information",
    "images",
    "feedback",
    "information",
    "images",
    "feedback",
  ];

  ItemDetailsModel? model;
  bool isLoading = false;
  getDetails(id) async {
    try {
      model = null;
      selectedTab = 0;
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.getDetails(id);
      response.fold((fail) {
        isLoading = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        if (success.data["data"] != null) {
          model = ItemDetailsModel.fromJson(success.data["data"]);
        } else {
          model = null;
        }
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
