
import 'package:restaurant_app/bloc/restaurant/model/shared_name.dart';

import 'customer_reviews.dart';
import 'menu.dart';

class DetailRestaurant {
  final String id;

  final String name;

  final String description;

  final String pictureId;

  final String city;

  final String address;

  final List<SharedName> categories;

  final List<CustomerReviews> customerReviews;

  final double rating;

  final Menu menu;

  DetailRestaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.address,
      required this.rating,
      required this.menu,
      required this.categories,
      required this.customerReviews});
}
