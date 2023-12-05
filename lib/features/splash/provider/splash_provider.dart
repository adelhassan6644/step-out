import 'package:flutter/foundation.dart';
import 'package:stepOut/features/setting/provider/setting_provider.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import '../../../data/config/di.dart';
import '../../../helpers/permissions.dart';
import '../../maps/provider/location_provider.dart';
import '../repo/splash_repo.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo splashRepo;
  SplashProvider({required this.splashRepo});

  startTheApp() {
    Future.delayed(const Duration(milliseconds: 4500), () async {
      sl<SettingProvider>().getSetting();

      ///Ask Notification Permission
      await PermissionHandler.checkNotificationsPermission();

      sl<LocationProvider>().getCurrentLocation();

      if (splashRepo.isFirstTime()) {
        CustomNavigator.push(Routes.ON_BOARDING, clean: true);
      }
      // else if (!splashRepo.isLogin()) {
      //   CustomNavigator.push(Routes.LOGIN, clean: true);
      // }
      else {
        CustomNavigator.push(Routes.DASHBOARD, clean: true, arguments: 0);
      }
      splashRepo.setFirstTime();
    });
  }
}
