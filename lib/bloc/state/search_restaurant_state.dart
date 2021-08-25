part of '../restaurant_state.dart';

class SearchRestaurantLoadingState extends RestaurantState {
  const SearchRestaurantLoadingState() : super();

  @override
  List<Object> get props => [];
}

class SearchRestaurantErrorState extends RestaurantState {
  final String message;

  SearchRestaurantErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class SearchRestaurantSuccessState extends RestaurantState {
  final List<Restaurant> restaurants;

  SearchRestaurantSuccessState(this.restaurants) : super();

  @override
  List<Object> get props => [];
}

class SearchRestaurantEmptyState extends RestaurantState {
  final String message;

  SearchRestaurantEmptyState(this.message);

  @override
  List<Object> get props => [message];
}