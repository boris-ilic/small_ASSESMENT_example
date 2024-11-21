import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'show_item_model.g.dart';

@JsonSerializable()
class ShowItemModel extends Equatable {
  final String itemID;
  final String itemName;
  @JsonKey(name: 'quantity_sold')
  final int quantitySold;

  const ShowItemModel({
    required this.itemID,
    required this.itemName,
    required this.quantitySold,
  });

  static var empty = const ShowItemModel(itemID: '', itemName: '', quantitySold: 0);


  /// Convert json response to custom object
  factory ShowItemModel.fromJson(Map<String, dynamic> json) => _$ShowItemModelFromJson(json);

  /// Convert our custom object to json format before writing data in database
  Map<String, dynamic> toJson() => _$ShowItemModelToJson(this);

  @override
  List<Object> get props => [itemID, itemName, quantitySold];
}
