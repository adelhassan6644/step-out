import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import '../model/news_model.dart';
import '../repo/news_repo.dart';

class NewsProvider extends ChangeNotifier {
  final NewsRepo repo;

  NewsProvider({required this.repo});

  bool get isLogin => repo.isLoggedIn();

  bool isLoading = false;
  NewsModel? model;
  getNews() async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.getNews();
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
}
