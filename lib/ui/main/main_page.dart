import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_item.dart';
import 'package:restaurant_app/data/parser/restaurant_parser.dart';
import 'package:restaurant_app/ui/shared/custom_loading_indicator.dart';
import 'package:restaurant_app/ui/detail/detail_restaurant_page.dart';
import 'package:restaurant_app/utils/colors.dart';

import '../shared/custom_error_image.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  static const String routeName = '/main_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        titleSpacing: 16,
        title: Text('Restaurant App',
            style: Theme.of(context).textTheme.headline6),
        brightness: Brightness.dark,
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/restaurants.json'),
          builder: (context, snapshot) {
            final List<RestaurantItem> restaurants =
                parseRestaurants(snapshot.data);
            return MainPage(restaurants: restaurants);
          },
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final List<RestaurantItem> restaurants;

  const MainPage({Key? key, required this.restaurants}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController searchController = new TextEditingController();

  List<RestaurantItem> _searchResult = [];

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  style: TextStyle(fontSize: 14, color: whiteColor),
                  keyboardType: TextInputType.text,
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: whiteColor),
                    suffixIcon: InkWell(
                        onTap: () {
                          onSearchQuery(searchController.text);
                        },
                        child: Icon(
                          Icons.search,
                          size: 16,
                          color: whiteColor,
                        )),
                  ),
                ),
              ],
            ),
          ),
          (searchController.text.isNotEmpty)
              ? _buildSearchResults()
              : _initialRestaurantList()
        ],
      ),
    );
  }

  Widget _initialRestaurantList() {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.restaurants.length,
        itemBuilder: (context, index) {
          return _buildContainerMain(widget.restaurants[index]);
        });
  }

  Widget _buildSearchResults() {
    if (_searchResult.isNotEmpty) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _searchResult.length,
        itemBuilder: (context, index) {
          return _buildContainerMain(_searchResult[index]);
        },
      );
    } else {
      return Container(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 50,
              color: Colors.red[700],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Restaurant not found",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      );
    }
  }

  Widget _buildContainerMain(RestaurantItem data) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.of(context)
                .pushNamed(DetailRestaurantPage.routeName, arguments: data);
          },
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                height: 80,
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                    tag: data.pictureId,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: data.pictureId,
                      placeholder: (context, url) => CustomLoadingIndicator(),
                      errorWidget: (context, url, error) => CustomErrorImage(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.name,
                        style: Theme.of(context).textTheme.subtitle2),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(data.city,
                            style: Theme.of(context).textTheme.bodyText2)
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amberAccent,
                          size: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(data.rating.toString(),
                            style: Theme.of(context).textTheme.bodyText2)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onSearchQuery(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    final setString = Set<String>();
    final uniqueLocationList =
        widget.restaurants.where((str) => setString.add(str.name)).toList();
    setState(() {
      uniqueLocationList.forEach((data) {
        if (data.name.toLowerCase().contains(text.toLowerCase())) {
          _searchResult.add(data);
        }
      });
    });
  }
}
