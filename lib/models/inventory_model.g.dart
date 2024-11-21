// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryModel _$InventoryModelFromJson(Map<String, dynamic> json) =>
    InventoryModel(
      itemID: json['itemID'] as int,
      itemName: json['itemName'] as String,
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$InventoryModelToJson(InventoryModel instance) =>
    <String, dynamic>{
      'itemID': instance.itemID,
      'itemName': instance.itemName,
      'quantity': instance.quantity,
    };
