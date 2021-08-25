import 'package:restaurant_app/data/model/request/customer_review_request.dart';
import 'package:restaurant_app/data/model/response/add_customer_reviews_response.dart';
import 'package:restaurant_app/data/model/response/detail_restaurant_response.dart';
import 'package:restaurant_app/data/model/response/restaurant_response.dart';
import 'package:restaurant_app/data/model/response/search_restaurant_response.dart';
import 'package:restaurant_app/data/remote/restaurant_api_client.dart';

class RestaurantApi implements RestaurantApiClient {
  final RestaurantApiClient _apiClient;

  RestaurantApi(this._apiClient);

  @override
  Future<AddCustomerReviewsResponse> addCustomerReview(
      String authToken, CustomerReviewRequest customerReviewRequest) {
    return _apiClient.addCustomerReview(authToken, customerReviewRequest);
  }

  @override
  Future<DetailRestaurantResponse> getDetailRestaurant(String id) {
    return _apiClient.getDetailRestaurant(id);
  }

  @override
  Future<RestaurantResponse> getRestaurantData() {
    return _apiClient.getRestaurantData();
  }

  @override
  Future<SearchRestaurantResponse> searchRestaurants(String query) {
    return _apiClient.searchRestaurants(query);
  }
}
