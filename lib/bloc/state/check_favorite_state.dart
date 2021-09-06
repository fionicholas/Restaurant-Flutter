part of '../restaurant_state.dart';

class CheckFavoriteLoadingState extends RestaurantState {
  const CheckFavoriteLoadingState() : super();

  @override
  List<Object> get props => [];
}

class UnfavorableState extends RestaurantState {
  final String message;
  final bool isFavorite;

  UnfavorableState(this.message, this.isFavorite);

  @override
  List<Object> get props => [message, isFavorite];
}

class FavoredState extends RestaurantState {
  final bool isFavorite;

  FavoredState({
    required this.isFavorite,
  }) : super();

  @override
  List<Object> get props => [isFavorite];
}
