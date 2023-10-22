import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/custom_navigation.dart';
import '../model/news_model.dart';
import '../repo/news_repo.dart';

class NewsProvider extends ChangeNotifier {
  final NewsRepo repo;

  NewsProvider({required this.repo});

  bool get isLogin => repo.isLoggedIn();

  List<int> favouriteId = [];

  bool isLoading = false;
  NewsModel? model;
  getNews() async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.getFavourites();
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: l.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      }, (response) {
        model = NewsModel.fromJson(response.data);
        favouriteId = [];
        if (model!.data != null && model!.data!.isNotEmpty) {
          for (var e in model!.data!) {
            if (e.id != null) {
              favouriteId.add(e.id!);
            }
          }
        }
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }

  updateFavourites({required int id, bool isExist = false}) async {
    try {
      if (isExist) {
        favouriteId.remove(id);
      } else {
        favouriteId.add(id);
      }
      notifyListeners();

      Either<ServerFailure, Response> response = await repo.updateFavourite(id);
      response.fold((l) {
        showToast(l.error);
      }, (response) {
        if (isExist) {
          showToast("تم الازالة من الاماكن المفضلة");
        } else {
          showToast("تم الاضافة الي الاماكن المفضلة");
        }
      });
      getNews();
      notifyListeners();
    } catch (e) {
      showToast(
        getTranslated("something_went_wrong",
            CustomNavigator.navigatorState.currentContext!),
      );
      notifyListeners();
    }
  }
}
