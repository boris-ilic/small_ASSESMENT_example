import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maka_assessment/helpers/dio_errors.dart';
import 'package:maka_assessment/models/bloc_progress.dart';
import 'package:maka_assessment/models/inventory_model.dart';
import 'package:maka_assessment/repositories/api_repository.dart';
part 'inventory_state.dart';

class InventoryBloc extends Cubit<InventoryState> {
  final ApiRepository _apiRepository;

  InventoryBloc(this._apiRepository) : super(InventoryState.initial());

  void updateItemId(String itemID) {
    int idAsInt = int.tryParse(itemID) ?? 0;
    emit(state.copyWith(itemID: idAsInt));
  }

  void clearBlocKeepItems() {
    List<InventoryModel> items = [...state.items];
    emit(InventoryState.initialWithSavedList(items));
  }

  void updateItemName(String itemName) {
    emit(state.copyWith(itemName: itemName));
  }

  void updateItemQuantity(String quantity) {
    int quantityAsInt = int.tryParse(quantity) ?? 0;
    emit(state.copyWith(quantity: quantityAsInt));
  }

  void validateForm(bool isFormValid) {
    emit(state.copyWith(isValid: isFormValid));
  }

  void addItemToItemList() {
    InventoryModel item =
        InventoryModel(itemID: state.itemID, itemName: state.itemName, quantity: state.quantity);
    List<InventoryModel> items = [...state.items, item];

    emit(state.copyWith(items: items));
  }

  Future<void> saveItems() async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      await _apiRepository.saveItems(state.items);
      emit(state.copyWith(blocProgress: BlocProgress.IS_SUCCESS, items: []));
    } catch (e) {
      emit(state.copyWith(blocProgress: BlocProgress.FAILED));
      if (e is DioException) {
        //NOTE: Reason why I put UI in this example is just for
        //presentation for colleague and explanation that this code is not testable
        BotToast.showText(text: getExceptionMessage(e));
      } else {
        BotToast.showText(text: "Something wrong!!!");
      }
    }
  }
}
