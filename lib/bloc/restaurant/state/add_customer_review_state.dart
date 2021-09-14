part of '../restaurant_state.dart';

class AddCustomerReviewLoadingState extends RestaurantState {
  const AddCustomerReviewLoadingState() : super();

  @override
  List<Object> get props => [];
}

class AddCustomerReviewErrorState extends RestaurantState {
  final String message;

  AddCustomerReviewErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class AddCustomerReviewSuccessState extends RestaurantState {
  AddCustomerReviewSuccessState() : super();

  @override
  List<Object> get props => [];
}
