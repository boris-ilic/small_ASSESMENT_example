import 'package:flutter/material.dart';
import 'package:maka_assessment/models/show_item_model.dart';

class ItemTile extends StatelessWidget {
  final ShowItemModel item;
  final Function buyMe;
  const ItemTile({
    required this.item,
    required this.buyMe,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.itemName),
      subtitle: Text("Quantity Sold: ${item.quantitySold}"),
      trailing: IconButton(onPressed: () => buyMe(), icon: const Icon(Icons.shopping_cart)),
    );
  }
}
