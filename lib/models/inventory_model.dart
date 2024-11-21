import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'inventory_model.g.dart';

@JsonSerializable()
class InventoryModel extends Equatable {
  final int itemID;
  final String itemName;
  final int quantity;

  const InventoryModel({
    required this.itemID,
    required this.itemName,
    required this.quantity,
  });

  static var empty = const InventoryModel(itemID: 0, itemName: '', quantity: 0);


  /// Convert json response to custom object
  factory InventoryModel.fromJson(Map<String, dynamic> json) => _$InventoryModelFromJson(json);

  /// Convert our custom object to json format before writing data in database
  Map<String, dynamic> toJson() => _$InventoryModelToJson(this);

  @override
  List<Object> get props => [itemID, itemName, quantity];
}
