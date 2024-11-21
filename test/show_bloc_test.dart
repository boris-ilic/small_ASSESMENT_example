import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maka_assessment/blocs/show_bloc/show_bloc.dart';
import 'package:maka_assessment/models/bloc_progress.dart';
import 'package:mockito/mockito.dart';
import 'package:maka_assessment/models/show_item_model.dart';
import 'package:maka_assessment/repositories/api_repository.dart';

class MockApiRepository extends Mock implements ApiRepository {
  @override
  Future<List<ShowItemModel>> getShowItems(int showId) =>
      super.noSuchMethod(Invocation.method(#getShowItems, [showId]),
          returnValue: Future.value(<ShowItemModel>[]));

  @override
  Future<int> buyItem(int showId, int itemId) => super
      .noSuchMethod(Invocation.method(#buyItem, [showId, itemId]), returnValue: Future.value(0));
}

void main() {
  
  group('ShowBloc', () {
    ShowBloc? showBloc;
    MockApiRepository? mockApiRepository;

    setUp(() {
      mockApiRepository = MockApiRepository();
      showBloc = ShowBloc(mockApiRepository!);
    });

    tearDown(() {
      showBloc?.close();
    });

    test('Initial state is correct', () {
      expect(showBloc?.state, ShowState.initial());
    });

    test('updateProgress changes the state to NOT_STARTED', () {
      showBloc?.updateProgress();
      expect(showBloc?.state.blocProgress, BlocProgress.NOT_STARTED);
    });

    group('getShowItems', () {
      final List<ShowItemModel> tItems = [
        const ShowItemModel(itemID: "1", itemName: "Test Item", quantitySold: 1)
      ];

      test('emits [loading, loaded] when getShowItems succeeds', () async {
        when(mockApiRepository!.getShowItems(1)).thenAnswer((_) async => tItems);

        final expected = [
          const ShowState(items: [], blocProgress: BlocProgress.IS_LOADING, errorMessage: ''),
          ShowState(items: tItems, blocProgress: BlocProgress.LOADED, errorMessage: ''),
        ];

        expectLater(showBloc?.stream, emitsInOrder(expected));

        showBloc?.getShowItems(1);
      });

      test('emits [loading, failed] when getShowItems fails', () async {
        when(mockApiRepository!.getShowItems(1))
            .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        final expected = [
          const ShowState(items: [], blocProgress: BlocProgress.IS_LOADING, errorMessage: ''),
          const ShowState(
              items: [],
              blocProgress: BlocProgress.FAILED,
              errorMessage: 'Unknown Error, Check API url or parameters are invalid'),
        ];

        expectLater(showBloc?.stream, emitsInOrder(expected));

        showBloc?.getShowItems(1);
      });
    });

    group('buyItem', () {
      test('emits [loading, success] when buyItem succeeds', () async {
        when(mockApiRepository!.buyItem(1, 2)).thenAnswer((_) async => 200);

        final expected = [
          const ShowState(items: [], blocProgress: BlocProgress.IS_LOADING, errorMessage: ''),
          const ShowState(items: [], blocProgress: BlocProgress.IS_SUCCESS, errorMessage: ''),
        ];

        expectLater(showBloc?.stream, emitsInOrder(expected));

        showBloc?.buyItem(1, "2");
      });

      test('emits [loading, failed] when buyItem fails', () async {
        when(mockApiRepository!.buyItem(1, 2))
            .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        final expected = [
          const ShowState(items: [], blocProgress: BlocProgress.IS_LOADING, errorMessage: ''),
          const ShowState(
              items: [],
              blocProgress: BlocProgress.FAILED,
              errorMessage: 'Unknown Error, Check API url or parameters are invalid'),
        ];

        expectLater(showBloc?.stream, emitsInOrder(expected));

        showBloc?.buyItem(1, "2");
      });

      test('emits [loading, failed] when buyItem fails because of wrong method parameters ',
          () async {
        when(mockApiRepository!.buyItem(1, 2))
            .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        final expected = [
          const ShowState(items: [], blocProgress: BlocProgress.IS_LOADING, errorMessage: ''),
          const ShowState(
              items: [],
              blocProgress: BlocProgress.FAILED,
              errorMessage: 'Something wrong!!!'),
        ];

        expectLater(showBloc?.stream, emitsInOrder(expected));

        showBloc?.buyItem(1, "3");
      });
    });
  });
}
