import 'package:stepOut/features/auth/pages/change_password.dart';
import 'package:stepOut/features/auth/pages/reset_password.dart';
import 'package:stepOut/features/category_details/page/category_details.dart';
import 'package:stepOut/main_models/base_model.dart';
import 'package:flutter/material.dart';
import 'package:stepOut/main_page/pages/main_page.dart';
import '../features/auth/pages/forget_password.dart';
import '../features/auth/pages/login.dart';
import '../features/auth/pages/register.dart';
import '../features/auth/pages/verification.dart';
import '../features/contact_with_us/page/contact_with_us.dart';
import '../features/home/page/news.dart';
import '../features/maps/page/map_page.dart';
import '../features/on_boarding/pages/on_boarding.dart';
import '../features/place_details/page/place_details.dart';
import '../features/splash/page/splash.dart';
import '../main.dart';
import 'routes.dart';

abstract class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldState =
      GlobalKey<ScaffoldMessengerState>();

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.APP:
        return _pageRoute(const MyApp());
      case Routes.SPLASH:
        return _pageRoute(const Splash());
      case Routes.ON_BOARDING:
        return _pageRoute(const OnBoarding());
      case Routes.LOGIN:
        return _pageRoute(Login(
          fromMain:
              settings.arguments != null ? settings.arguments as bool : false,
        ));
      case Routes.FORGET_PASSWORD:
        return _pageRoute(const ForgetPassword());
      case Routes.RESET_PASSWORD:
        return _pageRoute(const ResetPassword());
      case Routes.REGISTER:
        return _pageRoute(const Register());
      case Routes.CHANGE_PASSWORD:
        return _pageRoute(const ChangePassword());
      case Routes.VERIFICATION:
        return _pageRoute(
            Verification(fromRegister: settings.arguments as bool));

      case Routes.MAIN_PAGE:
        return _pageRoute(const MainPage());

      case Routes.NEWS:
        return _pageRoute(const News());

      case Routes.MAP:
        return _pageRoute(MapPage(
            baseModel: settings.arguments != null
                ? settings.arguments as BaseModel
                : null));

      case Routes.CATEGORY_DETAILS:
        return _pageRoute(CategoryDetails(id: settings.arguments as int));

      case Routes.PLACE_DETAILS:
        return _pageRoute(PlaceDetails(id: settings.arguments as int));

      case Routes.CONTACT_WITH_US:
        return _pageRoute(const ContactWithUs());

      // case Routes.ABOUT_US:
      //   return _pageRoute(const AboutUs());
      //
      // case Routes.TERMS:
      //   return _pageRoute(const Terms());

      default:
        return MaterialPageRoute(builder: (_) => const MyApp());
    }
  }

  static PageRouteBuilder<dynamic> _pageRoute(Widget child) => PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 100),
      reverseTransitionDuration: const Duration(milliseconds: 100),
      transitionsBuilder: (c, anim, a2, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var curveAnimation =
            CurvedAnimation(parent: anim, curve: Curves.linearToEaseOut);
        return SlideTransition(
          position: tween.animate(curveAnimation),
          child: child,
        );
      },
      opaque: false,
      pageBuilder: (_, __, ___) => child);

  static pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  static push(String routeName,
      {arguments, bool replace = false, bool clean = false}) {
    if (clean) {
      return navigatorState.currentState!.pushNamedAndRemoveUntil(
          routeName, (_) => false,
          arguments: arguments);
    } else if (replace) {
      return navigatorState.currentState!.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );
    } else {
      return navigatorState.currentState!
          .pushNamed(routeName, arguments: arguments);
    }
  }
}
