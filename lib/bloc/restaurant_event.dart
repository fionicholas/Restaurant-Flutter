import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/request/customer_review_request.dart';

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
