import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stepOut/components/loading_dialog.dart';
import 'package:stepOut/features/item_details/model/item_details_model.dart';
import 'package:stepOut/features/item_details/provider/item_details_provider.dart';
import 'package:stepOut/features/profile/provider/profile_provider.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/custom_navigation.dart';
import '../repo/ratting_repo.dart';

class RattingProvider extends ChangeNotifier {
  final RattingRepo repo;
  RattingProvider({
    required this.repo,
  });

  bool get isLogin => repo.isLoggedIn();

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

  sendFeedback(
      {ItemDetailsModel? model,
      required Function(ItemDetailsModel) onChange}) async {
    if (ratting != -1) {
      try {
        CustomNavigator.pop();
        loadingDialog();
        notifyListeners();

        var body = {
          "client_id": repo.getUserId(),
          "place_id": model?.id,
          "rating": (ratting + 1),
          "comment": feedback.value.toString().trim()
        };
        FeedbackModel feedbackModel = FeedbackModel(
          image: sl<ProfileProvider>().profileModel?.image,
          name: sl<ProfileProvider>().profileModel?.name,
          rating: (ratting + 1),
          comment: feedback.value.toString().trim(),
          createdAt: DateTime.now(),
        );

        Either<ServerFailure, Response> response = await repo.sendRatting(body);

        response.fold((fail) {
          CustomNavigator.pop();
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: fail.error,
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent));
          clear();
        }, (response) {
          Future.delayed(Duration.zero, () {
            model?.feedbacks?.add(feedbackModel);
            onChange(model!);
          });
          clear();
          CustomNavigator.pop();
        });

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
