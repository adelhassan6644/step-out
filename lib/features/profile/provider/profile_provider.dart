import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/app/core/utils/app_snack_bar.dart';
import 'package:stepOut/components/loading_dialog.dart';
import 'package:stepOut/features/auth/provider/auth_provider.dart';
import 'package:stepOut/features/profile/model/profile_model.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../repo/profile_repo.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepo profileRepo;
  ProfileProvider({required this.profileRepo});

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
    updateProfile(updatePhoto: true);
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
  updateProfile({bool updatePhoto = false}) async {
    Map<String, dynamic> body = {
      "name": profileModel?.name?.trim(),
      "phone": profileModel?.phone?.trim(),
    };

    if (checkData(body) || hasImage()) {
      if (profileImage != null) {
        body.addAll({
          "photo": MultipartFile.fromFileSync(profileImage!.path),
        });
      }
      if (_boolCheckString(phone.value?.trim(), "phone", body)) {
        body["phone"] = phone.value?.trim();
      }
      if (_boolCheckString(name.value?.trim(), "name", body)) {
        body["name"] = name.value?.trim();
      }

      try {
        if (updatePhoto) {
          loadingDialog();
        } else {
          isUpdate = true;
        }
        notifyListeners();
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
          getProfile(withLoading: false);
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: getTranslated("your_profile_successfully_updated",
                      CustomNavigator.navigatorState.currentContext!),
                  isFloating: true,
                  backgroundColor: Styles.ACTIVE,
                  borderColor: Colors.transparent));
          if (!updatePhoto) {
            CustomNavigator.pop();
          }
        });
        if (updatePhoto) {
          CustomNavigator.pop();
        } else {
          isUpdate = false;
        }
        notifyListeners();
      } catch (e) {
        if (updatePhoto) {
          CustomNavigator.pop();
        } else {
          isUpdate = false;
        }
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: e.toString(),
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Styles.RED_COLOR,
                isFloating: true));
        notifyListeners();
      }
    } else {
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
  getProfile({bool withLoading = true}) async {
    try {
      if (withLoading) {
        isLoading = true;
        notifyListeners();
      }

      Either<ServerFailure, Response> response = await profileRepo.getProfile();

      response.fold((fail) {
        showToast(ApiErrorHandler.getMessage(fail));
      }, (response) {
        profileModel = ProfileModel.fromJson(response.data['data']);
        initProfileData();
      });
      if (withLoading) {
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      if (withLoading) {
        isLoading = false;
        notifyListeners();
      }
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Styles.RED_COLOR,
              isFloating: true));
      notifyListeners();
    }
  }

  deleteAcc() async {
    try {
      CustomNavigator.pop();
      loadingDialog();
      notifyListeners();

      Either<ServerFailure, Response> response = await profileRepo.deleteAcc();
      CustomNavigator.pop();

      response.fold((fail) {
        showToast(ApiErrorHandler.getMessage(fail));
      }, (response) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: getTranslated("your_acc_deleted_successfully",
                    CustomNavigator.navigatorState.currentContext!),
                backgroundColor: Styles.ACTIVE,
                borderColor: Styles.ACTIVE,
                isFloating: true));
        Future.delayed(Duration.zero, () => sl<AuthProvider>().logOut());
      });
      notifyListeners();
    } catch (e) {
      CustomNavigator.pop();
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
    updateName(profileModel?.name);
    updatePhone(profileModel?.phone);
    notifyListeners();
  }
}
