import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/data/model/response/detail_restaurant_item.dart';

part 'detail_restaurant_response.g.dart';

@JsonSerializable()
class DetailRestaurantResponse extends Equatable {
  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'restaurant')
  final DetailRestaurantItem restaurant;

  DetailRestaurantResponse({
    this.error,
    this.message,
    required this.restaurant,
  });

  @override
  List<Object?> get props => [
        error,
        message,
        restaurant,
      ];

  factory DetailRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailRestaurantResponseFromJson(json);
}
