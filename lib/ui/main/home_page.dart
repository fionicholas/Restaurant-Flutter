import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/model/restaurant.dart';
import 'package:restaurant_app/bloc/restaurant_bloc.dart';
import 'package:restaurant_app/bloc/restaurant_event.dart';
import 'package:restaurant_app/bloc/restaurant_state.dart';
import 'package:restaurant_app/ui/shared/container_restaurants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _fetchRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      buildWhen: (previousState, state) {
        return state is FetchRestaurantsErrorState ||
            state is FetchRestaurantsLoadingState ||
            state is FetchRestaurantsSuccessState;
      },
      builder: (context, state) {
        if (state is FetchRestaurantsSuccessState) {
          List<Restaurant> restaurants = state.restaurants;
          return _buildHomePage(restaurants: restaurants);
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
    );
  }

  Widget _buildHomePage({required List<Restaurant> restaurants}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildRestaurantList(restaurants),
        ],
      ),
    );
  }

  Widget _buildRestaurantList(List<Restaurant> restaurants) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return ContainerRestaurants(data: restaurants[index]);
      },
    );
  }

  _fetchRestaurant() {
    context.read<RestaurantBloc>().add(FetchedRestaurantsEvent());
  }
}
