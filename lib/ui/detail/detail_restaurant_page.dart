import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_item.dart';
import 'package:restaurant_app/utils/colors.dart';

import '../shared/custom_error_image.dart';
import '../shared/custom_loading_indicator.dart';
import '../shared/custom_menus_card.dart';

class DetailRestaurantPage extends StatefulWidget {
  final RestaurantItem restaurantItem;

  const DetailRestaurantPage({Key? key, required this.restaurantItem})
      : super(key: key);

  static const String routeName = '/detail_restaurant';

  @override
  _DetailRestaurantPageState createState() => _DetailRestaurantPageState();
}

const double _silverAppBarExtendedHeight = 300.0;
const double _paddingTopOfTitle = 20.0;

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  var _top = 0.0;
  final _scrollDistance = _silverAppBarExtendedHeight - kToolbarHeight;
  ValueNotifier<double> _collapsingAppBarNotifier = ValueNotifier(0.0);
  late ScrollController _scrollController;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _collapsingAppBarNotifier.value = _scrollController.offset;
    });
  }

  Widget _appBarTitle() {
    return ValueListenableBuilder(
      valueListenable: _collapsingAppBarNotifier,
      builder: (BuildContext context, double value, Widget? child) {
        if (value >= _scrollDistance) {
          return Text(
            widget.restaurantItem.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            brightness: Brightness.dark,
            backgroundColor: primaryColor,
            elevation: 0.0,
            expandedHeight: _silverAppBarExtendedHeight,
            floating: false,
            leading: Container(
              margin: EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.50),
                  shape: BoxShape.circle),
              child: GestureDetector(
                child: Icon(Icons.arrow_back),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            title: _appBarTitle(),
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                _top = constraints.biggest.height;
                return Stack(
                  children: [
                    FlexibleSpaceBar(
                      background: Hero(
                        tag: widget.restaurantItem.pictureId,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.restaurantItem.pictureId,
                          placeholder: (context, url) => CustomLoadingIndicator(),
                          errorWidget: (context, url, error) =>
                              CustomErrorImage(),
                        ),
                      ),
                    ),
                    Visibility(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: _paddingTopOfTitle,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.0),
                              topRight: Radius.circular(24.0),
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      visible: (_top >
                          MediaQuery.of(context).padding.top + kToolbarHeight),
                    ),
                  ],
                );
              },
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.fromLTRB(24, 16, 24,16),
            sliver: SliverFillRemaining(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.restaurantItem.name,
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(widget.restaurantItem.city,
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Overview',
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.restaurantItem.description,
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Foods',
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 2,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.restaurantItem.menus.foods.length,
                          itemBuilder: (context, index) {
                            return CustomMenusCard(
                                image: 'assets/images/ic_foods.jpg',
                                name: widget
                                    .restaurantItem.menus.foods[index].name);
                          }),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Drinks',
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 2,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.restaurantItem.menus.drinks.length,
                          itemBuilder: (context, index) {
                            return CustomMenusCard(
                                image: 'assets/images/ic_drinks.jpg',
                                name: widget
                                    .restaurantItem.menus.drinks[index].name);
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
