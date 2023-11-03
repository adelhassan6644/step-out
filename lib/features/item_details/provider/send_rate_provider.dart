import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/custom_navigation.dart';
import '../repo/ratting_repo.dart';

class RattingProvider extends ChangeNotifier {
  final RattingRepo repo;
  RattingProvider({
    required this.repo,
  });

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final feedback = BehaviorSubject<String?>();
  Function(String?) get updateFeedback => feedback.sink.add;
  Stream<String?> get feedbackStream => feedback.stream.asBroadcastStream();

  int ratting = -1;
  selectedRate(value) {
    ratting = value;
    notifyListeners();
  }

  clear() {
    ratting = -1;
    updateFeedback(null);
  }

  bool isLoading = false;

  sendFeedback(id) async {
    if (ratting != -1) {
      try {
        isLoading = true;
        notifyListeners();

        var body = {
          "client_id": repo.getUserId(),
          "id": id,
          "rating": (ratting + 1),
          "feedback": feedback.value.toString().trim()
        };
        Either<ServerFailure, Response> response = await repo.sendRatting(body);
        response.fold((fail) {
          clear();
          CustomNavigator.pop();
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: fail.error,
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent));
        }, (response) {
          CustomNavigator.pop();
          clear();
        });
        isLoading = false;
        notifyListeners();
      } catch (e) {
        CustomNavigator.pop();
        clear();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: e.toString(),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      }
    } else {
      Future.delayed(
          Duration.zero,
          () => showToast(getTranslated("please_enter_your_feedback",
              CustomNavigator.navigatorState.currentContext!)));
    }
  }
}
