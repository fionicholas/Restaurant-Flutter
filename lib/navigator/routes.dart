import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_item.dart';
import 'package:restaurant_app/ui/detail/detail_restaurant_page.dart';
import 'package:restaurant_app/ui/main/main_page.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DetailRestaurantPage.routeName:
        final args = settings.arguments as RestaurantItem;
        return MaterialPageRoute(
            builder: (_) => DetailRestaurantPage(
                  restaurantItem: args,
                ));
      case MainApp.routeName:
        return MaterialPageRoute(builder: (_) => MainApp());
      default:
        return null;
    }
  }
}
