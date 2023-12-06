import 'dart:io';
import 'package:stepOut/app/core/utils/app_snack_bar.dart';
import 'package:stepOut/app/core/utils/text_styles.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import '../../app/localization/language_constant.dart';

class NetworkInfo {
  final Connectivity connectivity;
  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  static void checkConnectivity({Function()? onVisible}) {
    bool firstTime = true;
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (!firstTime) {
        bool isNotConnected;
        if (result == ConnectivityResult.none) {
          isNotConnected = true;
        } else {
          isNotConnected = !await _updateConnectivityStatus();
        }
        isNotConnected ? null : CustomSnackBar.hideSnackBar();
        // isNotConnected ?null : Future.delayed(const Duration(seconds: 1),() {
        //   CustomNavigator.pop();
        //   CustomNavigator.pop();
        // });
        // Future.delayed(
        //     Duration.zero,
        //         () => CustomSimpleDialog.parentSimpleDialog(customListWidget: [
        //           CheckConnectionDialog(isConnected:!isNotConnected ,)
        //     ]));
        ScaffoldMessenger.of(CustomNavigator.navigatorState.currentContext!)
            .showSnackBar(SnackBar(
          backgroundColor: isNotConnected
              ? Colors.red.withOpacity(0.85)
              : Colors.green.withOpacity(0.85),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(width: 1, color: Colors.transparent)),
          margin: const EdgeInsets.all(24),
          duration: Duration(seconds: isNotConnected ? 6000 : 2),
          onVisible: !isNotConnected ? onVisible : null,
          content: Row(
            children: [
              Icon(
                isNotConnected ? Icons.wifi_off : Icons.wifi,
                color: Colors.white,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                getTranslated(!isNotConnected ? "connected" : "no_connection",
                    CustomNavigator.navigatorState.currentContext!),
                style: AppTextStyles.medium
                    .copyWith(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
      }
      firstTime = false;
    });
  }

  static Future<bool> _updateConnectivityStatus() async {
    bool isConnected = true;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } catch (e) {
      isConnected = false;
    }
    return isConnected;
  }
}
