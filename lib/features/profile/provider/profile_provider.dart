import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/app/core/utils/app_snack_bar.dart';
import 'package:stepOut/features/profile/model/profile_model.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../repo/profile_repo.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepo profileRepo;
  ProfileProvider({required this.profileRepo}) {
    if (isLogin) {
      getProfile();
    }
  }

  bool get isLogin => profileRepo.isLoggedIn();

  ProfileModel? profileModel;

  final name = BehaviorSubject<String?>();
  Function(String?) get updateName => name.sink.add;
  Stream<String?> get nameStream => name.stream.asBroadcastStream();

  final phone = BehaviorSubject<String?>();
  Function(String?) get updatePhone => phone.sink.add;
  Stream<String?> get phoneStream => phone.stream.asBroadcastStream();

  File? profileImage;
  onSelectImage(File? file) {
    profileImage = file;
    updateProfile();
    notifyListeners();
  }

  clear() {
    profileImage = null;
    updateName(null);
    updatePhone(null);
    profileModel = null;
  }

  hasImage() {
    if (profileImage != null || profileModel?.image != null) {
      return true;
    } else {
      // showToast(getTranslated("please_select_profile_image",
      //     CustomNavigator.navigatorState.currentContext!));
      return false;
    }
  }

  bool _boolCheckString(dynamic value, String key, Map<String, dynamic> body) {
    if (value != null && value != "" && value != body[key]) {
      return true;
    } else {
      return false;
    }
  }

  bool checkData(Map<String, dynamic> body) {
    return _boolCheckString(name.value?.trim(), "name", body) ||
        _boolCheckString(phone.value?.trim(), "phone", body);
  }

  bool isUpdate = false;
  updateProfile() async {
    isUpdate = true;
    Map<String, dynamic> body = {
      "name": profileModel?.name,
      "phone": profileModel?.phone,
      // "email": profileModel?.email,
    };

    if (checkData(body) || hasImage()) {
      if (profileImage != null) {
        body.addAll({
          "photo": await MultipartFile.fromFile(profileImage!.path),
        });
      }
      if (_boolCheckString(phone.value?.trim(), "phone", body)) {
        body["phone"] = phone.value?.trim();
      }
      if (_boolCheckString(name.value?.trim(), "name", body)) {
        body["name"] = name.value?.trim();
      }

      try {
        log(body.entries.toString());
        Either<ServerFailure, Response> response =
            await profileRepo.updateProfile(body: body);
        response.fold((fail) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: ApiErrorHandler.getMessage(fail),
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.red));
        }, (response) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: getTranslated("your_profile_successfully_updated",
                      CustomNavigator.navigatorState.currentContext!),
                  isFloating: true,
                  backgroundColor: Styles.ACTIVE,
                  borderColor: Colors.transparent));
        });
        isUpdate = false;
        notifyListeners();
      } catch (e) {
        isUpdate = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: e.toString(),
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Styles.RED_COLOR,
                isFloating: true));
        notifyListeners();
      }
    } else {
      isUpdate = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: getTranslated("you_must_change_something",
                  CustomNavigator.navigatorState.currentContext!),
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Styles.RED_COLOR,
              isFloating: true));
      notifyListeners();
    }
  }

  bool isLoading = false;
  getProfile() async {
    try {
      isLoading = true;
      notifyListeners();

      Either<ServerFailure, Response> response = await profileRepo.getProfile();

      response.fold((fail) {
        showToast(ApiErrorHandler.getMessage(fail));
        isLoading = false;
        notifyListeners();
      }, (response) {
        profileModel = ProfileModel.fromJson(response.data['data']);
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      isLoading = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Styles.RED_COLOR,
              isFloating: true));
      notifyListeners();
    }
  }

  initProfileData() {
    updatePhone(profileModel?.phone);
    updateName(profileModel?.name);
  }
}
