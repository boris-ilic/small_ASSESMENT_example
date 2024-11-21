import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maka_assessment/helpers/dio_errors.dart';
import 'package:maka_assessment/models/bloc_progress.dart';
import 'package:maka_assessment/models/show_item_model.dart';
import 'package:maka_assessment/repositories/api_repository.dart';

part 'show_state.dart';

class ShowBloc extends Cubit<ShowState> {
  final ApiRepository _apiRepository;
  ShowBloc(this._apiRepository) : super(ShowState.initial());

  void updateProgress() {
    emit(state.copyWith(blocProgress: BlocProgress.NOT_STARTED));
  }

  Future<void> getShowItems(int showId) async {
    List<ShowItemModel> showItems = [];
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      showItems = await _apiRepository.getShowItems(showId);
      emit(state.copyWith(blocProgress: BlocProgress.LOADED, items: showItems, errorMessage: ''));
    } catch (e) {
      if (e is DioException) {
        emit(state.copyWith(
            blocProgress: BlocProgress.FAILED, errorMessage: getExceptionMessage(e)));
      } else {
        emit(state.copyWith(blocProgress: BlocProgress.FAILED, errorMessage: "Something wrong!!!"));
      }
    }
  }

  Future<int> buyItem(int showId, String itemId) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));
    int response = 0;
    try {
      int itemIdAsInt = int.tryParse(itemId) ?? 0;
      response = await _apiRepository.buyItem(showId, itemIdAsInt);
      emit(state.copyWith(blocProgress: BlocProgress.IS_SUCCESS, errorMessage: ''));
    } catch (e) {
      if (e is DioException) {
        emit(state.copyWith(
            blocProgress: BlocProgress.FAILED, errorMessage: getExceptionMessage(e)));
      } else {
        emit(state.copyWith(blocProgress: BlocProgress.FAILED, errorMessage: "Something wrong!!!"));
      }
    }
    return response;
  }
}
