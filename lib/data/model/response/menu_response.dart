import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/data/model/response/shared_name_item.dart';

part 'menu_response.g.dart';

@JsonSerializable()
class MenuResponse extends Equatable {
  @JsonKey(name: 'foods')
  final List<SharedNameItem>? foods;

  @JsonKey(name: 'drinks')
  final List<SharedNameItem>? drinks;

  MenuResponse({required this.foods, required this.drinks});

  @override
  List<Object?> get props => [foods, drinks];

  factory MenuResponse.fromJson(Map<String, dynamic> json) =>
      _$MenuResponseFromJson(json);
}
