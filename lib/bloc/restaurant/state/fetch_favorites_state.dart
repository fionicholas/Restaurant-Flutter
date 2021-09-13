part of '../restaurant_state.dart';

class FetchFavoritesLoadingState extends RestaurantState {
  const FetchFavoritesLoadingState() : super();

  @override
  List<Object> get props => [];
}

class FetchFavoritesErrorState extends RestaurantState {
  final String message;

  FetchFavoritesErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class FetchFavoritesSuccessState extends RestaurantState {
  final List<Restaurant> restaurants;

  FetchFavoritesSuccessState(this.restaurants) : super();

  @override
  List<Object> get props => [];
}

class FetchFavoritesEmptyState extends RestaurantState {
  final String emptyMessage;

  FetchFavoritesEmptyState(this.emptyMessage) : super();

  @override
  List<Object> get props => [];
}
