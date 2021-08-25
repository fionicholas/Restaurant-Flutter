import 'package:equatable/equatable.dart';
import 'package:restaurant_app/bloc/model/detail_restaurant.dart';
import 'package:restaurant_app/bloc/model/restaurant.dart';

part 'state/add_customer_review_state.dart';
part 'state/fetch_restaurant_detail_state.dart';
part 'state/fetch_restaurants_state.dart';
part 'state/search_restaurant_state.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState() : super();
}

class RestaurantInitialState extends RestaurantState {
  const RestaurantInitialState() : super();

  @override
  List<Object?> get props => [];
}
