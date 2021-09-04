part of '../restaurant_state.dart';

class DeleteFavoriteLoadingState extends RestaurantState {
  const DeleteFavoriteLoadingState() : super();

  @override
  List<Object> get props => [];
}

class DeleteFavoriteErrorState extends RestaurantState {
  final String message;

  DeleteFavoriteErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteFavoriteSuccessState extends RestaurantState {
  DeleteFavoriteSuccessState() : super();

  @override
  List<Object> get props => [];
}