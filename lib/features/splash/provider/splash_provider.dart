import 'package:flutter/foundation.dart';
import 'package:stepOut/features/setting/provider/setting_provider.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import '../../../data/config/di.dart';
import '../../../helpers/permissions.dart';
import '../../maps/provider/location_provider.dart';
import '../repo/splash_repo.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo repo;
  SplashProvider({required this.repo});

  startTheApp() {
    Future.delayed(const Duration(milliseconds: 1800), () async {
      sl<SettingProvider>().getSetting();
      if (!repo.isLogin) {
        await repo.guestMode();
      }

      ///Ask Notification Permission
      await PermissionHandler.checkNotificationsPermission();

      sl<LocationProvider>().getCurrentLocation();

      if (repo.isFirstTime) {
        CustomNavigator.push(Routes.ON_BOARDING, clean: true);
      }
      // else if (!splashRepo.isLogin()) {
      //   CustomNavigator.push(Routes.LOGIN, clean: true);
      // }
      else {
        CustomNavigator.push(Routes.DASHBOARD, clean: true, arguments: 0);
      }
      repo.setFirstTime();
    });
  }
}
