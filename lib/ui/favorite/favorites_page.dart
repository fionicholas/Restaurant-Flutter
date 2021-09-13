import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/restaurant/model/restaurant.dart';
import 'package:restaurant_app/bloc/restaurant/restaurant.dart';
import 'package:restaurant_app/ui/shared/container_restaurants.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _fetchFavorites(context);
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      buildWhen: (previousState, state) {
        return state is FetchFavoritesSuccessState ||
            state is FetchFavoritesLoadingState ||
            state is FetchFavoritesEmptyState ||
            state is FetchFavoritesErrorState;
      },
      builder: (context, state) {
        if (state is FetchFavoritesSuccessState) {
          List<Restaurant> restaurants = state.restaurants;
          return _buildHomePage(restaurants: restaurants);
        } else if (state is FetchFavoritesLoadingState) {
          return Padding(
            padding: EdgeInsets.only(top: 100),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is FetchFavoritesEmptyState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  color: Colors.red[700],
                  size: 40,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(state.emptyMessage)
              ],
            ),
          );
        } else if (state is FetchFavoritesErrorState) {
          return Center(
            child: Center(
              child: Text(state.message),
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(top: 100),
            child: Center(
              child: Text('ELSE'),
            ),
          );
        }
      },
    );
  }

  Widget _buildHomePage({required List<Restaurant> restaurants}) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return ContainerRestaurants(
          data: restaurants[index],
        );
      },
    );
  }

  _fetchFavorites(BuildContext context) {
    context.read<RestaurantBloc>().add(FetchedFavoritesEvent());
  }
}
