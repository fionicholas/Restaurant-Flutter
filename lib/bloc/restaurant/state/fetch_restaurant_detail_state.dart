part of '../restaurant_state.dart';

class FetchRestaurantDetailLoadingState extends RestaurantState {
  const FetchRestaurantDetailLoadingState() : super();

  @override
  List<Object> get props => [];
}

class FetchRestaurantDetailErrorState extends RestaurantState {
  final String message;

  FetchRestaurantDetailErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class FetchRestaurantDetailSuccessState extends RestaurantState {
  final DetailRestaurant detailRestaurant;

  FetchRestaurantDetailSuccessState(this.detailRestaurant) : super();

  @override
  List<Object> get props => [detailRestaurant];
}
