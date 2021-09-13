import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/restaurant/model/restaurant.dart';
import 'package:restaurant_app/bloc/restaurant/restaurant.dart';
import 'package:restaurant_app/ui/shared/container_restaurants.dart';
import 'package:restaurant_app/utils/colors.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  TextEditingController _searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchRestaurant(context, _searchController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
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
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.text,
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    suffixIcon: InkWell(
                        onTap: () {
                          _fetchRestaurant(context, _searchController.text);
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

  _fetchRestaurant(BuildContext context, String query) {
    context.read<RestaurantBloc>().add(SearchRestaurantEvent(
          query: query,
        ));
  }

  Widget _buildPage() {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      buildWhen: (previousState, state) {
        return state is SearchRestaurantErrorState ||
            state is SearchRestaurantLoadingState ||
            state is SearchRestaurantSuccessState ||
            state is SearchRestaurantEmptyState;
      },
      builder: (context, state) {
        if (state is SearchRestaurantSuccessState) {
          List<Restaurant> restaurants = state.restaurants;
          return _buildList(restaurants: restaurants);
        } else if (state is SearchRestaurantLoadingState) {
          return Padding(
            padding: EdgeInsets.only(top: 200),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is SearchRestaurantErrorState) {
          return Center(
            child: Center(
              child: Text(state.message),
            ),
          );
        } else if (state is SearchRestaurantEmptyState) {
          return Padding(
            padding: EdgeInsets.only(top: 200),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 40,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(state.message),
                ],
              ),
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
    return SizedBox(
      height: MediaQuery.of(context).size.height - 164,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return ContainerRestaurants(
            data: restaurants[index],
          );
        },
      ),
    );
  }
}
