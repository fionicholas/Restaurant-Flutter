import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_app/bloc/restaurant/mapper/restaurant_mapper.dart';
import 'package:restaurant_app/bloc/restaurant/model/detail_restaurant.dart';
import 'package:restaurant_app/bloc/restaurant/restaurant.dart';
import 'package:restaurant_app/ui/detail/components/container_customer_reviews.dart';
import 'package:restaurant_app/ui/detail/components/container_drinks.dart';
import 'package:restaurant_app/ui/detail/components/container_foods.dart';
import 'package:restaurant_app/ui/review/add_review_page.dart';
import 'package:restaurant_app/ui/shared/custom_button.dart';
import 'package:restaurant_app/utils/assets.dart';
import 'package:restaurant_app/utils/colors.dart';
import 'package:restaurant_app/utils/dialog_utils.dart';

import '../shared/custom_error_image.dart';
import '../shared/custom_loading_indicator.dart';

class DetailRestaurantPage extends StatefulWidget {
  final String id;

  const DetailRestaurantPage({Key? key, required this.id}) : super(key: key);

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
    _fetchRestaurantDetail();
    _checkFavoriteById();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _collapsingAppBarNotifier.value = _scrollController.offset;
    });
  }

  Widget _appBarTitle(String name) {
    return ValueListenableBuilder(
      valueListenable: _collapsingAppBarNotifier,
      builder: (BuildContext context, double value, Widget? child) {
        if (value >= _scrollDistance) {
          return Text(
            name,
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
    return WillPopScope(
      onWillPop: () async {
        _fetchFavorites();
        return true;
      },
      child: Scaffold(
        body: MultiBlocListener(
          child: _blocDetailRestaurant(),
          listeners: [
            BlocListener<RestaurantBloc, RestaurantState>(
              listener: (context, state) {
                if (state is AddToFavoriteLoadingState) {
                  showLoading(context);
                } else if (state is AddToFavoriteSuccessState) {
                  hideLoading(context);
                  _checkFavoriteById();
                  Fluttertoast.showToast(msg: 'Restaurant added to favorite');
                } else if (state is AddToFavoriteErrorState) {
                  hideLoading(context);
                  Fluttertoast.showToast(msg: 'something wrong');
                }
              },
            ),
            BlocListener<RestaurantBloc, RestaurantState>(
              listener: (context, state) {
                if (state is DeleteFavoriteLoadingState) {
                  showLoading(context);
                } else if (state is DeleteFavoriteSuccessState) {
                  hideLoading(context);
                  _checkFavoriteById();
                  Fluttertoast.showToast(msg: 'Remove from favorite');
                } else if (state is DeleteFavoriteErrorState) {
                  hideLoading(context);
                  Fluttertoast.showToast(msg: 'something wrong');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _blocDetailRestaurant() {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      buildWhen: (previousState, state) {
        return state is FetchRestaurantDetailLoadingState ||
            state is FetchRestaurantDetailSuccessState ||
            state is FetchRestaurantDetailErrorState;
      },
      builder: (context, state) {
        if (state is FetchRestaurantDetailSuccessState) {
          DetailRestaurant detailRestaurant = state.detailRestaurant;
          return _buildPage(detailRestaurant);
        } else if (state is FetchRestaurantDetailLoadingState) {
          return Padding(
            padding: EdgeInsets.only(top: 100),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is FetchRestaurantDetailErrorState) {
          return Center(
            child: Center(
              child: Text(state.message),
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(top: 100),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  _buildPage(DetailRestaurant detailRestaurant) {
    return CustomScrollView(
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
                color: primaryColor.withOpacity(0.50), shape: BoxShape.circle),
            child: GestureDetector(
              child: Icon(Icons.arrow_back),
              onTap: () => Navigator.maybePop(context),
            ),
          ),
          title: _appBarTitle(detailRestaurant.name),
          pinned: true,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              _top = constraints.biggest.height;
              return Stack(
                children: [
                  FlexibleSpaceBar(
                    background: Hero(
                      tag: detailRestaurant.pictureId,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: LARGE_IMAGE_URL + detailRestaurant.pictureId,
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
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
          sliver: SliverFillRemaining(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detailRestaurant.name,
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
                              Text(detailRestaurant.city,
                                  style: Theme.of(context).textTheme.bodyText1)
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        child: BlocBuilder<RestaurantBloc, RestaurantState>(
                          buildWhen: (previousState, state) {
                            return state is CheckFavoriteLoadingState ||
                                state is FavoredState ||
                                state is UnfavorableState;
                          },
                          builder: (context, state) {
                            if (state is FavoredState) {
                              var _isFavorite = state.isFavorite;
                              return (_isFavorite)
                                  ? _buttonFavorite(detailRestaurant.id)
                                  : _buttonNotFavorite(detailRestaurant);
                            } else if (state is UnfavorableState) {
                              var _isFavorite = state.isFavorite;
                              return (_isFavorite)
                                  ? _buttonFavorite(detailRestaurant.id)
                                  : _buttonNotFavorite(detailRestaurant);
                            } else if (state is CheckFavoriteLoadingState) {
                              return Padding(
                                padding: EdgeInsets.only(top: 100),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.only(top: 100),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                        ),
                      )
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
                    detailRestaurant.description,
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Foods',
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  ContainerFoods(
                    detailRestaurant: detailRestaurant,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Drinks',
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  ContainerDrinks(
                    detailRestaurant: detailRestaurant,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Customer Reviews',
                        style: Theme.of(context).textTheme.subtitle2,
                        textAlign: TextAlign.start,
                      ),
                      CustomButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AddReviewPage.routeName,
                                  arguments: detailRestaurant.id)
                              .then((value) => _onPageClosed(value));
                        },
                        textButton: 'Add Review',
                        btnColor: primaryColor,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ContainerCustomerReviews(
                    detailRestaurant: detailRestaurant,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buttonNotFavorite(DetailRestaurant detailRestaurant) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          context.read<RestaurantBloc>().add(AddToFavoriteEvent(
              restaurant: mapDetailToRestaurantItem(detailRestaurant)));
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.pinkAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.favorite_border,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buttonFavorite(String id) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          context.read<RestaurantBloc>().add(DeleteFavoriteEvent(id: id));
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.pinkAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.favorite,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _fetchRestaurantDetail() {
    context
        .read<RestaurantBloc>()
        .add(FetchedRestaurantDetailEvent(id: widget.id));
  }

  _checkFavoriteById() {
    BlocProvider.of<RestaurantBloc>(context)
        .add(CheckFavoriteEvent(id: widget.id));
  }

  _fetchFavorites() {
    context.read<RestaurantBloc>().add(FetchedFavoritesEvent());
  }

  _onPageClosed(void value) {
    _fetchRestaurantDetail();
  }
}
