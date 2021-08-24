import 'package:flutter/material.dart';
import 'package:restaurant_app/navigator/routes.dart';
import 'package:restaurant_app/ui/splash/splash_screen.dart';
import 'package:restaurant_app/utils/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      onGenerateRoute: Routes.generateRoute,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: myTextTheme,
          inputDecorationTheme: inputDecorationTheme()),
      home: SplashScreen(),
    );
  }
}
