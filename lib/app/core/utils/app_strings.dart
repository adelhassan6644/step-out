import '../../../features/maps/models/location_model.dart';

class AppStrings {
  static const String appName = 'Step Out';
  static const String googleApiKey = 'AIzaSyBxi2NcKA8JE90J07U9M2D90tHgaSg3Xjg';
  static const String defaultAddress = 'المملكة العربية السعودية ، الرياض';
  static const String defaultLat = '24.67401824245781';
  static const String defaultLong = '46.691234707832336';
  static LocationModel defaultPickUp = LocationModel(
      address: defaultAddress, longitude: defaultLong, latitude: defaultLat);
  static LocationModel defaultDrop = LocationModel(
      address: defaultAddress, longitude: defaultLong, latitude: defaultLat);

  static const String networkImage = 'https://images.unsplash.com/photo-1575936123452-b67c3203c357?auto=format&fit=crop&q=80&w=2940&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  static const String fontFamily = 'ar';
  static const String noRouteFound = 'No Route Found';
  static const String cachedRandomQuote = 'CACHED_RANDOM_QUOTE';
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String serverFailure = 'Server Failure';
  static const String cacheFailure = 'Cache Failure';
  static const String unexpectedError = 'Unexpected Error';
  static const String englishCode = 'en';
  static const String arabicCode = 'ar';
  static const String locale = 'locale';
}
