part of '../restaurant_state.dart';

class AddToFavoriteLoadingState extends RestaurantState {
  const AddToFavoriteLoadingState() : super();

  @override
  List<Object> get props => [];
}

class AddToFavoriteErrorState extends RestaurantState {
  final String message;

  AddToFavoriteErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class AddToFavoriteSuccessState extends RestaurantState {
  AddToFavoriteSuccessState() : super();

  @override
  List<Object> get props => [];
}