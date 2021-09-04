part of '../restaurant_state.dart';

class CheckFavoriteLoadingState extends RestaurantState {
  const CheckFavoriteLoadingState() : super();

  @override
  List<Object> get props => [];
}

class CheckFavoriteErrorState extends RestaurantState {
  final String message;

  CheckFavoriteErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class CheckFavoriteSuccessState extends RestaurantState {
  final FavoriteEntity favoriteEntity;
  final bool isFavorite;

  CheckFavoriteSuccessState({
    required this.favoriteEntity,
    required this.isFavorite,
  }) : super();

  @override
  List<Object> get props => [favoriteEntity, isFavorite];
}
