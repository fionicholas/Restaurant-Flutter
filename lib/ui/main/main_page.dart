import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/detail/detail_restaurant_page.dart';
import 'package:restaurant_app/ui/favorite/favorites_page.dart';
import 'package:restaurant_app/ui/search/search_page.dart';
import 'package:restaurant_app/ui/settings/settings_page.dart';
import 'package:restaurant_app/utils/colors.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

import 'home_page.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  static const String routeName = '/main_page';

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final FavoritesPage _favorite = FavoritesPage();
  final SettingsPage _settings = SettingsPage();

  final NotificationHelper _notificationHelper = NotificationHelper();

  Widget _showPages = HomePage();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return HomePage();
      case 1:
        return _favorite;
      case 2:
        return _settings;
      default:
        return new Container(
          child: Text(
            'Page Not Found',
            style: TextStyle(fontSize: 30.0),
          ),
        );
    }
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailRestaurantPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          titleSpacing: 16,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Restaurant App',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'Recommendation Restaurants for you!',
                style: TextStyle(
                    color: whiteColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          brightness: Brightness.dark,
          backgroundColor: primaryColor,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SearchPage.routeName);
              },
              icon: Icon(
                Icons.search,
                color: whiteColor,
              ),
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: primaryColor,
          items: <Widget>[
            Icon(
              Icons.restaurant,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.favorite,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.settings,
              size: 30,
              color: Colors.white,
            ),
          ],
          onTap: (index) {
            setState(() {
              _showPages = _pageChooser(index);
            });
          },
        ),
        body: _showPages);
  }
}
