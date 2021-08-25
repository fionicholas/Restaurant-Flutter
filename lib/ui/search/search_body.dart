import 'package:flutter/material.dart';
import 'package:restaurant_app/bloc/model/restaurant.dart';
import 'package:restaurant_app/bloc/restaurant_bloc.dart';
import 'package:restaurant_app/bloc/restaurant_event.dart';
import 'package:restaurant_app/bloc/restaurant_state.dart';
import 'package:restaurant_app/ui/shared/container_restaurants.dart';
import 'package:restaurant_app/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = new TextEditingController();
    return SingleChildScrollView(
      child: Column(
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
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.text,
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    suffixIcon: InkWell(
                        onTap: () {
                          _fetchRestaurant(context);
                        },
                        child: Icon(
                          Icons.search,
                          size: 16,
                          color: primaryColor,
                        )),
                  ),
                ),
              ],
            ),
          ),
          _buildPage(),
        ],
      ),
    );
  }

  _fetchRestaurant(BuildContext context) {
    context.read<RestaurantBloc>().add(FetchedRestaurantsEvent());
  }

  Widget _buildPage() {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      buildWhen: (previousState, state) {
        return state is FetchRestaurantsErrorState ||
            state is FetchRestaurantsLoadingState ||
            state is FetchRestaurantsSuccessState;
      },
      builder: (context, state) {
        if (state is FetchRestaurantsSuccessState) {
          List<Restaurant> restaurants = state.restaurants;
          return _buildList(restaurants: restaurants);
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

  _buildList({required List<Restaurant> restaurants}) {
    return Column(
      children: [
        ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return ContainerRestaurants(data: restaurants[index]);
          },
        )
      ],
    );
  }
}
