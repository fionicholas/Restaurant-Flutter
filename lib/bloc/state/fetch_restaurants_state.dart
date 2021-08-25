part of '../restaurant_state.dart';

class FetchRestaurantsLoadingState extends RestaurantState {
  const FetchRestaurantsLoadingState() : super();

  @override
  List<Object> get props => [];
}

class FetchRestaurantsErrorState extends RestaurantState {
  final String message;

  FetchRestaurantsErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class FetchRestaurantsSuccessState extends RestaurantState {
  final List<Restaurant> restaurants;

  FetchRestaurantsSuccessState(this.restaurants) : super();

  @override
  List<Object> get props => [];
}
