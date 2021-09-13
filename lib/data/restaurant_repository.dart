import 'package:restaurant_app/data/model/favorite_entity.dart';
import 'package:restaurant_app/data/model/request/customer_review_request.dart';
import 'package:restaurant_app/data/model/response/restaurant_item.dart';
import 'package:restaurant_app/data/model/response/restaurant_response.dart';

import 'model/response/customer_reviews_item.dart';
import 'model/response/detail_restaurant_item.dart';

abstract class RestaurantRepository {
  Future<List<CustomerReviewsItem>> addCustomerReview(
    CustomerReviewRequest customerReviewRequest,
  );

  Future<List<RestaurantItem>> getRestaurantData();

  Future<DetailRestaurantItem> getDetailRestaurant(String id);

  Future<List<RestaurantItem>> searchRestaurants(String query);

  Future getFavorites();

  Future<RestaurantResponse> getRestaurantsNotification();

  Future addToFavorite(FavoriteEntity favoriteEntity);

  Future deleteFavorite(String id);

  Future checkFavoriteById(String id);
}
