import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maka_assessment/blocs/inventory_bloc/inventory_bloc.dart';
import 'package:maka_assessment/components/primary_button.dart';
import 'package:maka_assessment/components/primary_input.dart';
import 'package:maka_assessment/helpers/validators.dart';
import 'package:maka_assessment/repositories/api_repository.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final _itemIdController = TextEditingController();

  final _itemIdFieldKey = GlobalKey<FormFieldState>();

  final _itemNameController = TextEditingController();

  final _itemNameFieldKey = GlobalKey<FormFieldState>();

  final _itemQuantityController = TextEditingController();

  final _itemQuantityFieldKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    clearControllers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InventoryBloc(context.read<ApiRepository>()),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
        child: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PrimaryInput(
                    textColor: Colors.grey[500],
                    controller: _itemIdController,
                    hintText: "Item ID",
                    labelText: "Item ID",
                    isValidationEnabled: true,
                    validator: Validators.validateNotEmpty,
                    fieldKey: _itemIdFieldKey,
                    keyboardType: TextInputType.number,
                    isOnlyNumbers: true,
                    isRequired: true,
                    borderSide: BorderSide(color: Colors.grey.shade400),
                    isNewUserField: true,
                    onChanged: (itemID) {
                      context.read<InventoryBloc>().updateItemId(itemID);
                      checkFormValidation(context);
                    }),
                const SizedBox(height: 20),
                PrimaryInput(
                    textColor: Colors.grey[500],
                    controller: _itemNameController,
                    hintText: "Item Name",
                    labelText: "Item Name",
                    isValidationEnabled: true,
                    validator: Validators.validateNotEmpty,
                    fieldKey: _itemNameFieldKey,
                    keyboardType: TextInputType.text,
                    isRequired: true,
                    borderSide: BorderSide(color: Colors.grey.shade400),
                    isNewUserField: true,
                    onChanged: (itemName) {
                      context.read<InventoryBloc>().updateItemName(itemName);
                      checkFormValidation(context);
                    }),
                const SizedBox(height: 20),
                PrimaryInput(
                    textColor: Colors.grey[500],
                    controller: _itemQuantityController,
                    hintText: "Item Quantity",
                    labelText: "Item Quantity",
                    isValidationEnabled: true,
                    validator: Validators.validateNotEmpty,
                    fieldKey: _itemQuantityFieldKey,
                    keyboardType: TextInputType.number,
                    isRequired: true,
                    borderSide: BorderSide(color: Colors.grey.shade400),
                    isNewUserField: true,
                    onChanged: (quantity) {
                      context.read<InventoryBloc>().updateItemQuantity(quantity);
                      checkFormValidation(context);
                    }),
                const SizedBox(height: 20),
                PrimaryButton(
                  isEnabled: state.isValid,
                  onTap: () async {
                    context.read<InventoryBloc>().addItemToItemList();

                    _showMyDialog(context).then((result) async {
                      if (result != null && result) {
                        //User pressed 'Yes' mean add another item
                        clearControllers();
                        context.read<InventoryBloc>().clearBlocKeepItems();
                      } else {
                        // User pressed 'No' mean save already presen items in cart
                        clearControllers();
                        await context.read<InventoryBloc>().saveItems();
                      }
                    });
                  },
                  label: "Add Item",
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void clearControllers() {
    _itemIdController.clear();
    _itemNameController.clear();
    _itemQuantityController.clear();
  }

  void checkFormValidation(BuildContext context) {
    final title = _itemIdFieldKey.currentState?.isValid ?? false;
    final description = _itemNameFieldKey.currentState?.isValid ?? false;
    final quantity = _itemQuantityFieldKey.currentState?.isValid ?? false;
    var isFormValid = title && description && quantity;
    context.read<InventoryBloc>().validateForm(isFormValid);
  }
}

Future<bool?> _showMyDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // User must tap on a button to close the dialog
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Do you want to add more items?'),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
