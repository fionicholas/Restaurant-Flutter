import 'package:dio/dio.dart';
import 'package:restaurant_app/data/model/request/customer_review_request.dart';
import 'package:restaurant_app/data/model/response/add_customer_reviews_response.dart';
import 'package:restaurant_app/data/model/response/detail_restaurant_response.dart';
import 'package:restaurant_app/data/model/response/restaurant_response.dart';
import 'package:restaurant_app/data/model/response/search_restaurant_response.dart';
import 'package:restaurant_app/di/injector.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_api_client.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class RestaurantApiClient {
  factory RestaurantApiClient(Dio dio, {String baseUrl}) = _RestaurantApiClient;

  @POST('review')
  @FormUrlEncoded()
  Future<AddCustomerReviewsResponse> addCustomerReview(
    @Header('X-Auth-Token') String authToken,
    @Body() CustomerReviewRequest customerReviewRequest,
  );

  @GET('list')
  Future<RestaurantResponse> getRestaurantData();

  @GET('detail/{id}')
  Future<DetailRestaurantResponse> getDetailRestaurant(
    @Path('id') String id,
  );

  @GET('search')
  Future<SearchRestaurantResponse> searchRestaurants(
    @Query('q') String query,
  );
}
