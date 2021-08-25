import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/bloc_observer.dart';
import 'package:restaurant_app/bloc/restaurant.dart';
import 'package:restaurant_app/di/injector.dart';
import 'package:restaurant_app/navigator/routes.dart';
import 'package:restaurant_app/ui/splash/splash_screen.dart';
import 'package:restaurant_app/utils/styles.dart';

void main() {
  injectModules();
  Bloc.observer = BlocObserverApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final RestaurantBloc _restaurantBloc = locator.get();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return _restaurantBloc;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant App',
        onGenerateRoute: Routes.generateRoute,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: myTextTheme,
            inputDecorationTheme: inputDecorationTheme()),
        home: SplashScreen(),
      ),
    );
  }
}
