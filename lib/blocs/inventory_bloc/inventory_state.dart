// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'inventory_bloc.dart';

class InventoryState extends Equatable {
  final List<InventoryModel> items;
  final int itemID;
  final String itemName;
  final int quantity;
  final bool isValid;
  final BlocProgress blocProgress;

  const InventoryState({
    required this.items,
    required this.itemID,
    required this.itemName,
    required this.quantity,
    required this.isValid,
    required this.blocProgress,
  });

  factory InventoryState.initial() {
    return const InventoryState(
      items: [],
      itemID: 0,
      itemName: '',
      quantity: 0,
      isValid: false,
      blocProgress: BlocProgress.NOT_STARTED,
    );
  }
  factory InventoryState.initialWithSavedList(List<InventoryModel> items) {
    return InventoryState(
      items: items,
      itemID: 0,
      itemName: '',
      quantity: 0,
      isValid: false,
      blocProgress: BlocProgress.NOT_STARTED,
    );
  }

  InventoryState copyWith({
    List<InventoryModel>? items,
    int? itemID,
    String? itemName,
    int? quantity,
    bool? isValid,
    BlocProgress? blocProgress,
  }) {
    return InventoryState(
      items: items ?? this.items,
      itemID: itemID ?? this.itemID,
      itemName: itemName ?? this.itemName,
      quantity: quantity ?? this.quantity,
      isValid: isValid ?? this.isValid,
      blocProgress: blocProgress ?? this.blocProgress,
    );
  }

  @override
  List<Object?> get props => [items, itemID, itemName, quantity, isValid, blocProgress];
}
