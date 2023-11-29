import 'package:dio/dio.dart';
import 'package:stepOut/features/home/repo/home_repo.dart';
import 'package:stepOut/features/maps/provider/location_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stepOut/features/search/repo/search_repo.dart';
import '../../app/theme/theme_provider/theme_provider.dart';
import '../../features/auth/provider/auth_provider.dart';
import '../../features/category_details/provider/category_details_provider.dart';
import '../../features/category_details/repo/category_details_repo.dart';
import '../../features/contact_with_us/provider/contact_provider.dart';
import '../../features/contact_with_us/repo/contact_repo.dart';
import '../../features/hashtag_places/provider/hashtag_places_provider.dart';
import '../../features/hashtag_places/repo/hashtag_places_repo.dart';
import '../../features/home/provider/home_provider.dart';
import '../../features/item_details/provider/item_details_provider.dart';
import '../../features/item_details/provider/send_rate_provider.dart';
import '../../features/item_details/repo/item_details_repo.dart';
import '../../features/item_details/repo/ratting_repo.dart';
import '../../features/language/provider/localization_provider.dart';
import '../../features/language/repo/localization_repo.dart';
import '../../features/maps/repo/maps_repo.dart';
import '../../features/news/provider/news_provider.dart';
import '../../features/news/repo/news_repo.dart';
import '../../features/notifications/provider/notifications_provider.dart';
import '../../features/notifications/repo/notifications_repo.dart';
import '../../features/profile/provider/profile_provider.dart';
import '../../features/profile/repo/profile_repo.dart';
import '../../features/search/provider/search_provider.dart';
import '../../features/setting/provider/setting_provider.dart';
import '../../features/setting/repo/setting_repo.dart';
import '../../main_page/provider/main_page_provider.dart';
import '../../main_providers/map_provider.dart';
import '../api/end_points.dart';
import '../network/netwok_info.dart';
import '../dio/dio_client.dart';
import '../dio/logging_interceptor.dart';
import '../../features/auth/repo/auth_repo.dart';
import '../../features/splash/provider/splash_provider.dart';
import '../../features/splash/repo/splash_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => DioClient(
        EndPoints.baseUrl,
        dio: sl(),
        loggingInterceptor: sl(),
        sharedPreferences: sl(),
      ));

  // Repository
  sl.registerLazySingleton(() => LocalizationRepo(dioClient: sl()));

  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => AuthRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => ProfileRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => HomeRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => NewsRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => MapsRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => CategoryDetailsRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => ItemDetailsRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => RattingRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => SettingRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => ContactRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => NotificationsRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => SearchRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => HashtagPlacesRepo(sharedPreferences: sl(), dioClient: sl()));

  //provider
  sl.registerLazySingleton(
      () => LocalizationProvider(sharedPreferences: sl(), repo: sl()));
  sl.registerLazySingleton(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerLazySingleton(() => MainPageProvider());
  sl.registerLazySingleton(() => SplashProvider(splashRepo: sl()));
  sl.registerLazySingleton(() => AuthProvider(authRepo: sl()));
  sl.registerLazySingleton(() => NewsProvider(repo: sl()));
  sl.registerLazySingleton(() => CategoryDetailsProvider(repo: sl()));
  sl.registerLazySingleton(() => ItemDetailsProvider(repo: sl()));
  sl.registerLazySingleton(() => RattingProvider(repo: sl()));
  sl.registerLazySingleton(() => HomeProvider(homeRepo: sl()));
  sl.registerLazySingleton(() => ProfileProvider(profileRepo: sl()));
  sl.registerLazySingleton(() => MapProvider());
  sl.registerLazySingleton(() => LocationProvider(locationRepo: sl()));
  sl.registerLazySingleton(() => NotificationsProvider(repo: sl()));
  sl.registerLazySingleton(() => SettingProvider(repo: sl()));
  sl.registerLazySingleton(() => ContactProvider(contactRepo: sl()));
  sl.registerLazySingleton(() => SearchProvider(repo: sl()));
  sl.registerLazySingleton(() => HashtagPlacesProvider(repo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
