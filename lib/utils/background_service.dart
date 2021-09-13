import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:restaurant_app/data/model/response/restaurant_response.dart';
import 'package:restaurant_app/data/remote/restaurant_api.dart';
import 'package:restaurant_app/data/remote/restaurant_api_client.dart';
import 'package:restaurant_app/ui/main.dart';

import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future callback() async {
    final Dio dio = Dio();
    final RestaurantApiClient restaurantApiClient = RestaurantApiClient(dio);
    final RestaurantApi restaurantApi = RestaurantApi(restaurantApiClient);
    final NotificationHelper _notificationHelper = NotificationHelper();
    RestaurantResponse restaurantsResponse =
        await restaurantApi.getRestaurantData();
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, restaurantsResponse);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
