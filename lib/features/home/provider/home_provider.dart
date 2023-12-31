import 'package:carousel_slider/carousel_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/data/error/api_error_handler.dart';
import 'package:stepOut/features/home/models/banner_model.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import '../models/categories_model.dart';
import '../models/offers_model.dart';
import '../repo/home_repo.dart';

class HomeProvider extends ChangeNotifier {
  HomeRepo homeRepo;
  HomeProvider({required this.homeRepo});

  bool get isLogin => homeRepo.isLoggedIn();

  CarouselController bannerController = CarouselController();
  int bannerIndex = 0;
  void setBannerIndex(int index) {
    bannerIndex = index;
    notifyListeners();
  }

  BannerModel? bannerModel;
  bool isGetBanners = false;
  getBanners() async {
    try {
      isGetBanners = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await homeRepo.getHomeBanner();
      response.fold((fail) {
        isGetBanners = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        bannerModel = BannerModel.fromJson(success.data);
        isGetBanners = false;
        notifyListeners();
      });
    } catch (e) {
      isGetBanners = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  CategoriesModel? categoriesModel;
  bool isGetCategories = false;
  getCategories() async {
    try {
      isGetCategories = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await homeRepo.getHomeCategories();
      response.fold((fail) {
        isGetCategories = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        categoriesModel = CategoriesModel.fromJson(success.data);
        isGetCategories = false;
        notifyListeners();
      });
    } catch (e) {
      isGetCategories = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  OffersModel? offersModel;
  bool isGetOffers = false;
  getOffers() async {
    try {
      isGetOffers = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await homeRepo.getHomeOffers();
      response.fold((fail) {
        isGetOffers = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        offersModel = OffersModel.fromJson(success.data);
        isGetOffers = false;
        notifyListeners();
      });
    } catch (e) {
      isGetOffers = false;
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
