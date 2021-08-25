import 'package:restaurant_app/data/model/request/customer_review_request.dart';
import 'package:restaurant_app/data/model/response/customer_reviews_item.dart';
import 'package:restaurant_app/data/model/response/detail_restaurant_item.dart';
import 'package:restaurant_app/data/model/response/restaurant_item.dart';
import 'package:restaurant_app/data/remote/restaurant_api.dart';
import 'package:restaurant_app/data/restaurant_repository.dart';

class RestaurantDataSource extends RestaurantRepository {
  final RestaurantApi _restaurantApi;

  RestaurantDataSource(this._restaurantApi);

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
}
