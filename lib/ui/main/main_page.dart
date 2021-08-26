import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/model/restaurant.dart';
import 'package:restaurant_app/bloc/restaurant.dart';
import 'package:restaurant_app/bloc/restaurant_state.dart';
import 'package:restaurant_app/ui/search/search_page.dart';
import 'package:restaurant_app/ui/shared/container_restaurants.dart';
import 'package:restaurant_app/utils/colors.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  static const String routeName = '/main_page';

  @override
  Widget build(BuildContext context) {
    _fetchRestaurant(context);
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
                  color: whiteColor, fontSize: 11, fontWeight: FontWeight.w400),
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
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
        buildWhen: (previousState, state) {
          return state is FetchRestaurantsErrorState ||
              state is FetchRestaurantsLoadingState ||
              state is FetchRestaurantsSuccessState;
        },
        builder: (context, state) {
          if (state is FetchRestaurantsSuccessState) {
            List<Restaurant> restaurants = state.restaurants;
            return MainPage(restaurants: restaurants);
          } else if (state is FetchRestaurantsLoadingState) {
            return Padding(
              padding: EdgeInsets.only(top: 100),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is FetchRestaurantsErrorState) {
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
      ),
    );
  }

  _fetchRestaurant(BuildContext context) {
    context.read<RestaurantBloc>().add(FetchedRestaurantsEvent());
  }
}

class MainPage extends StatefulWidget {
  final List<Restaurant> restaurants;

  const MainPage({Key? key, required this.restaurants}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildRestaurantList(),
        ],
      ),
    );
  }

  Widget _buildRestaurantList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.restaurants.length,
      itemBuilder: (context, index) {
        return ContainerRestaurants(data: widget.restaurants[index]);
      },
    );
  }
}
