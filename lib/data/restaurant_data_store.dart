import 'package:restaurant_app/data/local/favorite_dao.dart';
import 'package:restaurant_app/data/model/favorite_entity.dart';
import 'package:restaurant_app/data/model/request/customer_review_request.dart';
import 'package:restaurant_app/data/model/response/customer_reviews_item.dart';
import 'package:restaurant_app/data/model/response/detail_restaurant_item.dart';
import 'package:restaurant_app/data/model/response/restaurant_item.dart';
import 'package:restaurant_app/data/remote/restaurant_api.dart';
import 'package:restaurant_app/data/restaurant_repository.dart';

import 'model/response/restaurant_response.dart';

class RestaurantDataSource extends RestaurantRepository {
  final RestaurantApi _restaurantApi;
  final FavoriteDao _favoriteDao;

  RestaurantDataSource(this._restaurantApi, this._favoriteDao);

  @override
  Future<List<CustomerReviewsItem>> addCustomerReview(
    CustomerReviewRequest customerReviewRequest,
  ) {
    return _restaurantApi
        .addCustomerReview('12345', customerReviewRequest)
        .then((value) => value.customerReviews ?? List.empty());
  }

  @override
  Future<DetailRestaurantItem> getDetailRestaurant(String id) {
    return _restaurantApi
        .getDetailRestaurant(id)
        .then((value) => value.restaurant);
  }

  @override
  Future<List<RestaurantItem>> getRestaurantData() {
    return _restaurantApi
        .getRestaurantData()
        .then((value) => value.restaurants);
  }

  @override
  Future<List<RestaurantItem>> searchRestaurants(String query) {
    return _restaurantApi
        .searchRestaurants(query)
        .then((value) => value.restaurants);
  }

  @override
  Future addToFavorite(FavoriteEntity favoriteEntity) {
    return _favoriteDao.addToFavorite(favoriteEntity);
  }

  @override
  Future checkFavoriteById(String id) {
    return _favoriteDao.checkFavoriteById(id: id);
  }

  @override
  Future deleteFavorite(String id) {
    return _favoriteDao.deleteFavorite(id);
  }

  @override
  Future getFavorites() {
    return _favoriteDao.getFavorites();
  }

  @override
  Future<RestaurantResponse> getRestaurantsNotification() {
    return _restaurantApi.getRestaurantData().then((value) => value);
  }
}
