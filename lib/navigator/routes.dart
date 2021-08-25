import 'package:flutter/material.dart';
import 'package:restaurant_app/bloc/model/restaurant.dart';
import 'package:restaurant_app/ui/detail/detail_restaurant_page.dart';
import 'package:restaurant_app/ui/main/main_page.dart';
import 'package:restaurant_app/ui/review/add_review_page.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DetailRestaurantPage.routeName:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => DetailRestaurantPage(
            id: args,
          ),
        );
      case AddReviewPage.routeName:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => AddReviewPage(
            id: args,
          ),
        );
      case MainApp.routeName:
        return MaterialPageRoute(builder: (_) => MainApp());
      default:
        return null;
    }
  }
}
