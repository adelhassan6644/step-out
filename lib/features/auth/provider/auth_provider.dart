import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/features/profile/provider/profile_provider.dart';
import 'package:stepOut/features/success/model/success_model.dart';
import 'package:stepOut/main_page/provider/main_page_provider.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/confirmation_dialog.dart';
import '../../../components/custom_simple_dialog.dart';
import '../../../data/config/di.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../repo/auth_repo.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepo authRepo;
  AuthProvider({required this.authRepo}) {
    updateMail(kDebugMode ? "adel@gmail.com" : authRepo.getMail());
    mailTEC = TextEditingController(
        text: kDebugMode ? "adel@gmail.com" : authRepo.getMail());
  }

  final TextEditingController codeTEC = TextEditingController();

  final name = BehaviorSubject<String?>();
  Function(String?) get updateName => name.sink.add;
  Stream<String?> get nameStream => name.stream.asBroadcastStream();

  final phone = BehaviorSubject<String?>();
  Function(String?) get updatePhone => phone.sink.add;
  Stream<String?> get phoneStream => phone.stream.asBroadcastStream();

  late TextEditingController mailTEC;
  final mail = BehaviorSubject<String?>();
  Function(String?) get updateMail => mail.sink.add;
  Stream<String?> get mailStream => mail.stream.asBroadcastStream();

  final password = BehaviorSubject<String?>();
  Function(String?) get updatePassword => password.sink.add;
  Stream<String?> get passwordStream => password.stream.asBroadcastStream();

  final newPassword = BehaviorSubject<String?>();
  Function(String?) get updateNewPassword => newPassword.sink.add;
  Stream<String?> get newPasswordStream =>
      newPassword.stream.asBroadcastStream();

  final confirmPassword = BehaviorSubject<String?>();
  Function(String?) get updateConfirmPassword => confirmPassword.sink.add;
  Stream<String?> get confirmPasswordStream =>
      confirmPassword.stream.asBroadcastStream();

  Stream<bool> get loginStream =>
      Rx.combineLatest2(mailStream, passwordStream, (n, p) {
        if (Validations.mail(n as String) == null &&
            Validations.password(p) == null) {
          return true;
        }
        return false;
      });

  Stream<bool> get registerStream => Rx.combineLatest5(
          nameStream,
          phoneStream,
          mailStream,
          newPasswordStream,
          confirmPasswordStream, (a, b, c, d, e) {
        if (Validations.name(a as String) == null &&
            Validations.phone(b as String) == null &&
            Validations.mail(c as String) == null &&
            Validations.firstPassword(d as String) == null &&
            Validations.confirmNewPassword(d, e as String) == null) {
          return true;
        }
        return false;
      });

  Stream<bool> get changePasswordStream =>
      Rx.combineLatest3(passwordStream, newPasswordStream, confirmPassword,
          (a, b, c) {
        if (Validations.password(a as String) == null &&
            Validations.newPassword(a, b as String) == null &&
            Validations.confirmNewPassword(b, c as String) == null) {
          return true;
        }
        return false;
      });

  Stream<bool> get resetPasswordStream =>
      Rx.combineLatest2(newPasswordStream, confirmPasswordStream, (a, b) {
        if (Validations.firstPassword(a as String) == null &&
            Validations.confirmNewPassword(a, b as String) == null) {
          return true;
        }
        return false;
      });

  clear() {
    codeTEC.clear();
    updateName(null);
    updatePhone(null);
    updateMail(null);
    mailTEC.clear();
    updatePassword(null);
    updateNewPassword(null);
    updateConfirmPassword(null);
  }

  bool _isRememberMe = true;
  bool get isRememberMe => _isRememberMe;
  void onRememberMe(bool value) {
    _isRememberMe = value;
    notifyListeners();
  }

  bool _isAgree = true;
  bool get isAgree => _isAgree;
  void onAgree(bool value) {
    _isAgree = value;
    notifyListeners();
  }

  bool _isLogin = false;
  bool get isLogin => _isLogin;
  logIn() async {
    try {
      _isLogin = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.logIn(
          mail: mail.value!.trim(), password: password.value!.trim());
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: getTranslated("invalid_credentials",
                    CustomNavigator.navigatorState.currentContext!),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        ///To Remember
        if (_isRememberMe) {
          authRepo.remember(mail.value!.trim());
        } else {
          authRepo.forget();
        }

        authRepo.saveUserId(success.data['data']["id"]);
        if (success.data['data']["email_verified_at"] != null) {
          authRepo.setLoggedIn();
          CustomNavigator.push(Routes.DASHBOARD, clean: true, arguments: 0);
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: getTranslated("logged_in_successfully",
                      CustomNavigator.navigatorState.currentContext!),
                  isFloating: true,
                  backgroundColor: Styles.ACTIVE,
                  borderColor: Colors.transparent));
          clear();
        } else {
          CustomNavigator.push(Routes.VERIFICATION, arguments: true);
        }
      });
      _isLogin = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isLogin = false;
      notifyListeners();
    }
  }

  bool _isForget = false;
  bool get isForget => _isForget;
  forgetPassword() async {
    try {
      _isForget = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.forgetPassword(
        mail: mail.value!.trim(),
      );

      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        CustomNavigator.push(Routes.VERIFICATION, arguments: false);
      });

      _isForget = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isForget = false;
      notifyListeners();
    }
  }

  resend(fromRegister) async {
    await authRepo.resendCode(
      mail: mail.value!.trim(),
      fromRegister: fromRegister,
    );
  }

  bool _isVerify = false;
  bool get isVerify => _isVerify;
  verify(fromRegister) async {
    try {
      _isVerify = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.verifyMail(
          mail: mail.value!.trim(),
          code: codeTEC.text.trim(),
          fromRegister: fromRegister,
          updateHeader: fromRegister);

      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        if (fromRegister) {
          authRepo.setLoggedIn();
          CustomNavigator.push(
            Routes.SUCCESS_PAGE,
            clean: true,
            arguments: SuccessModel(
              title: getTranslated("register_success_title",
                  CustomNavigator.navigatorState.currentContext!),
              description: getTranslated("register_success_description",
                  CustomNavigator.navigatorState.currentContext!),
            ),
          );
          clear();
        } else {
          CustomNavigator.push(Routes.RESET_PASSWORD, replace: true);
        }
      });
      _isVerify = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isVerify = false;
      notifyListeners();
    }
  }

  bool _isReset = false;
  bool get isReset => _isReset;
  resetPassword() async {
    try {
      _isReset = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.reset(
          password: newPassword.value!.trim(), email: mail.value!.trim());
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        Future.delayed(
            Duration.zero,
            () => CustomSimpleDialog.parentSimpleDialog(
                    canDismiss: false,
                    customListWidget: [
                      ConfirmationDialog(
                        title: getTranslated("your_password_reset_successfully",
                            CustomNavigator.navigatorState.currentContext!),
                        description: getTranslated(
                            "your_password_reset_description",
                            CustomNavigator.navigatorState.currentContext!),
                        withOneButton: true,
                        txtBtn: getTranslated("login",
                            CustomNavigator.navigatorState.currentContext!),
                        onContinue: () =>
                            CustomNavigator.push(Routes.LOGIN, clean: true),
                      )
                    ]));
        clear();
      });
      _isReset = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isReset = false;
      notifyListeners();
    }
  }

  bool _isChange = false;
  bool get isChange => _isChange;
  changePassword() async {
    try {
      _isChange = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.change(
        oldPassword: password.value!.trim(),
        password: newPassword.value!.trim(),
      );
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        Future.delayed(
            Duration.zero,
            () => CustomSimpleDialog.parentSimpleDialog(
                    canDismiss: false,
                    customListWidget: [
                      ConfirmationDialog(
                        title: getTranslated(
                            "your_password_changed_successfully",
                            CustomNavigator.navigatorState.currentContext!),
                        description: getTranslated(
                            "your_password_reset_description",
                            CustomNavigator.navigatorState.currentContext!),
                        withOneButton: true,
                        txtBtn: getTranslated("confirm",
                            CustomNavigator.navigatorState.currentContext!),
                        onContinue: () => CustomNavigator.push(Routes.DASHBOARD,
                            clean: true, arguments: 3),
                      )
                    ]));
        clear();
      });
      _isChange = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isChange = false;
      notifyListeners();
    }
  }

  bool _isRegister = false;
  bool get isRegister => _isRegister;
  register() async {
    try {
      _isRegister = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.register(
        name: name.value!.trim(),
        mail: mail.value!.trim(),
        phone: phone.value!.trim(),
        password: newPassword.value!.trim(),
      );
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        authRepo.saveUserId(success.data['data']["id"]);
        CustomNavigator.push(Routes.VERIFICATION, arguments: true);
      });
      _isRegister = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isRegister = false;
      notifyListeners();
    }
  }

  logOut() async {
    CustomNavigator.push(Routes.SPLASH, clean: true);
    await authRepo.clearSharedData();
    clear();
    sl<ProfileProvider>().clear();
    sl<MainPageProvider>().updateDashboardIndex(0);
    CustomSnackBar.showSnackBar(
        notification: AppNotification(
            message: getTranslated("your_logged_out_successfully",
                CustomNavigator.navigatorState.currentContext!),
            isFloating: true,
            backgroundColor: Styles.ACTIVE,
            borderColor: Colors.transparent));
    notifyListeners();
  }
}
