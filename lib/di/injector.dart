import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurant_app/di/restaurant_module.dart';

GetIt locator = GetIt.instance;

const String baseUrl = 'https://restaurant-api.dicoding.dev/';

void injectModules() async {
  BaseOptions options = new BaseOptions(
      connectTimeout: 60000, receiveTimeout: 60000, followRedirects: false);
  Dio _dio = Dio(options);

  locator.registerSingleton(_dio);
  injectRestaurantModuleModule();
}
