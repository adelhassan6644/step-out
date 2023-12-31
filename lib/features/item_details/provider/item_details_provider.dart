import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
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

  ItemDetailsModel? model;
  bool isLoading = false;
  getDetails(id) async {
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
  }

  sharePlace() async {
    String link = "https://ebrandstepout.page.link/${model?.id}";
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(link),
      uriPrefix: "https://ebrandstepout.page.link",
      androidParameters: const AndroidParameters(
        packageName: "com.eBrandstepOut.stepOut",
      ),
      iosParameters: const IOSParameters(
        bundleId: "com.eBrandstepOut.stepOut",
        appStoreId: "6451453145",
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildLink(
      dynamicLinkParams,
    );
    String shareLink = Uri.decodeFull(
      Uri.decodeComponent(dynamicLink.toString()),
    );
    await Share.share(shareLink);
  }

  updateModel(v) {
    model = v;
    notifyListeners();
  }
}
