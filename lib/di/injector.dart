import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurant_app/data/local/favorite_dao.dart';
import 'package:restaurant_app/di/restaurant_module.dart';
import 'package:restaurant_app/utils/preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

const String baseUrl = 'https://restaurant-api.dicoding.dev/';

void injectModules() async {
  BaseOptions options = new BaseOptions(
      connectTimeout: 60000, receiveTimeout: 60000, followRedirects: false);
  Dio _dio = Dio(options);

  FavoriteDao _favoriteDao = FavoriteDao();

  locator.registerSingleton(_dio);
  locator.registerSingleton(_favoriteDao);

  locator.registerSingleton(
      PreferencesHelper(sharedPreferences: SharedPreferences.getInstance()));

  injectRestaurantModuleModule();
}
