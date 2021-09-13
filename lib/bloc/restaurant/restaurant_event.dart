import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/request/customer_review_request.dart';

import 'model/restaurant.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();
}

class AddedCustomerReviewsEvent extends RestaurantEvent {
  final CustomerReviewRequest customerReviewRequest;

  const AddedCustomerReviewsEvent({
    required this.customerReviewRequest,
  });

  @override
  List<Object?> get props => [customerReviewRequest];
}

class FetchedRestaurantsEvent extends RestaurantEvent {
  const FetchedRestaurantsEvent();

  @override
  List<Object?> get props => [];
}

class FetchedRestaurantDetailEvent extends RestaurantEvent {
  final String id;

  const FetchedRestaurantDetailEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class SearchRestaurantEvent extends RestaurantEvent {
  final String query;

  const SearchRestaurantEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

class AddToFavoriteEvent extends RestaurantEvent {
  final Restaurant restaurant;

  const AddToFavoriteEvent({required this.restaurant});

  @override
  List<Object?> get props => [restaurant];
}

class FetchedFavoritesEvent extends RestaurantEvent {
  const FetchedFavoritesEvent();

  @override
  List<Object?> get props => [];
}

class CheckFavoriteEvent extends RestaurantEvent {
  final String id;

  const CheckFavoriteEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteFavoriteEvent extends RestaurantEvent {
  final String id;

  const DeleteFavoriteEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
