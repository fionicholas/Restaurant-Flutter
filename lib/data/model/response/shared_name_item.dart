import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shared_name_item.g.dart';

@JsonSerializable()
class SharedNameItem extends Equatable {
  @JsonKey(name: 'name')
  final String name;

  SharedNameItem({required this.name});

  @override
  List<Object?> get props => [name];

  factory SharedNameItem.fromJson(Map<String, dynamic> json) =>
      _$SharedNameItemFromJson(json);
}
