// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowItemModel _$ShowItemModelFromJson(Map<String, dynamic> json) =>
    ShowItemModel(
      itemID: json['itemID'] as String,
      itemName: json['itemName'] as String,
      quantitySold: json['quantity_sold'] as int,
    );

Map<String, dynamic> _$ShowItemModelToJson(ShowItemModel instance) =>
    <String, dynamic>{
      'itemID': instance.itemID,
      'itemName': instance.itemName,
      'quantity_sold': instance.quantitySold,
    };
