import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:restaurant_app/data/model/response/restaurant_item.dart';
import 'package:restaurant_app/data/model/response/restaurant_response.dart';
import 'package:restaurant_app/data/remote/restaurant_api_client.dart';

late MockWebServer _server;
late RestaurantApiClient _client;
final _headers = {"Content-Type": "application/json"};
final dispatcherMap = <String, MockResponse>{};

void main() {
  setUp(() async {
    _server = MockWebServer();
    await _server.start();
    final dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true));
    _client = RestaurantApiClient(dio, baseUrl: _server.url);
  });

  tearDown(() {
    _server.shutdown();
  });

  test("test empty restaurant list", () async {
    _server.enqueue(body: mockEmptyResponseJson, headers: _headers);
    final tasks = await _client.getRestaurantData();
    expect(tasks.restaurants, isNotNull);
    expect(tasks.restaurants.length, 0);
  });

  test("test restaurant list", () async {
    _server.enqueue(body: mockRestaurantResponseJson, headers: _headers);
    final tasks = await _client.getRestaurantData();
    expect(tasks.restaurants, isNotNull);
    expect(tasks.restaurants.length, 1);
  });
}

final List<RestaurantItem> mockEmptyList = [];
final RestaurantResponse mockEmptyResponse = RestaurantResponse(
  error: false,
  count: 0,
  message: 'success',
  restaurants: mockEmptyList,
);
final mockEmptyResponseJson = jsonEncode(mockEmptyResponse);

final mockRestaurantItem = RestaurantItem(
  id: 's1knt6za9kkfw1e867',
  name: 'Kafe Kita',
  description:
      'Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi',
  pictureId: '25',
  city: 'Gorontalo',
  rating: 4,
);

final List<RestaurantItem> mockRestaurants = []..add(mockRestaurantItem);

final RestaurantResponse mockRestaurantResponse = RestaurantResponse(
  error: false,
  count: 1,
  message: 'success',
  restaurants: mockRestaurants,
);
final mockRestaurantResponseJson = jsonEncode(mockRestaurantResponse);
