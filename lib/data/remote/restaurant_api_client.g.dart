// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestaurantApiClient implements RestaurantApiClient {
  _RestaurantApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://restaurant-api.dicoding.dev/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AddCustomerReviewsResponse> addCustomerReview(
      authToken, customerReviewRequest) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(customerReviewRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddCustomerReviewsResponse>(Options(
                method: 'POST',
                headers: <String, dynamic>{r'X-Auth-Token': authToken},
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'review',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddCustomerReviewsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RestaurantResponse> getRestaurantData() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RestaurantResponse>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RestaurantResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DetailRestaurantResponse> getDetailRestaurant(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DetailRestaurantResponse>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'detail/$id',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DetailRestaurantResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchRestaurantResponse> searchRestaurants(query) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'q': query};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchRestaurantResponse>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'search',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchRestaurantResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
