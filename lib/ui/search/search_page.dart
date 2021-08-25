import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/search/search_body.dart';
import 'package:restaurant_app/utils/colors.dart';

class SearchPage extends StatelessWidget {
  static const String routeName = '/search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        titleSpacing: 16,
        title: Text('Search', style: Theme.of(context).textTheme.headline6),
        brightness: Brightness.dark,
        backgroundColor: primaryColor,
      ),
      body: SearchBody(),
    );
  }
}
