import 'package:restaurant_app/bloc/restaurant/restaurant_bloc.dart';
import 'package:restaurant_app/bloc/scheduler/scheduler.dart';
import 'package:restaurant_app/data/remote/restaurant_api.dart';
import 'package:restaurant_app/data/remote/restaurant_api_client.dart';
import 'package:restaurant_app/data/restaurant_data_store.dart';
import 'package:restaurant_app/data/restaurant_repository.dart';
import 'package:restaurant_app/di/injector.dart';

void injectRestaurantModuleModule() {
  locator.registerSingleton(RestaurantApiClient(locator.get()));
  locator.registerSingleton(RestaurantApi(locator.get()));
  locator.registerSingleton<RestaurantRepository>(
      RestaurantDataSource(locator.get(), locator.get()));
  locator.registerSingleton(RestaurantBloc(locator.get()));
  locator.registerSingleton(SchedulerBloc(locator.get()));
}
