import 'dart:convert';

import 'package:restaurant_app/data/model/restaurant_item.dart';

List<RestaurantItem> parseRestaurants(String? jsonString) {
  if (jsonString == null) {
    return [];
  }

  final List parsed = jsonDecode(jsonString)['restaurants'];
  return parsed
      .map((json) => RestaurantItem.fromJson(json))
      .toList();
}
