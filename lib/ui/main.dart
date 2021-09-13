import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/bloc_observer.dart';
import 'package:restaurant_app/bloc/restaurant/restaurant.dart';
import 'package:restaurant_app/bloc/scheduler/scheduler.dart';
import 'package:restaurant_app/data/remote/restaurant_api_client.dart';
import 'package:restaurant_app/di/injector.dart';
import 'package:restaurant_app/navigator/navigation_helper.dart';
import 'package:restaurant_app/navigator/routes.dart';
import 'package:restaurant_app/ui/splash/splash_screen.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/utils/styles.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  injectModules();
  Bloc.observer = BlocObserverApp();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final RestaurantBloc _restaurantBloc = locator.get();
  final SchedulerBloc _schedulerBloc = locator.get();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) {
            return _restaurantBloc;
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return _schedulerBloc;
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant App',
        onGenerateRoute: Routes.generateRoute,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: myTextTheme,
            inputDecorationTheme: inputDecorationTheme()),
        navigatorKey: navigatorKey,
        home: SplashScreen(),
      ),
    );
  }
}
