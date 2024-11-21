part of 'show_bloc.dart';

class ShowState extends Equatable {
  final List<ShowItemModel> items;
  final BlocProgress blocProgress;
  final String errorMessage;

  const ShowState({required this.items, required this.blocProgress,required this.errorMessage});

  factory ShowState.initial() {
    return const ShowState(items: [], blocProgress: BlocProgress.NOT_STARTED, errorMessage: '');
  }

  ShowState copyWith({
    List<ShowItemModel>? items,
    BlocProgress? blocProgress,
    String? errorMessage,
  }) {
    return ShowState(
      items: items ?? this.items,
      blocProgress: blocProgress ?? this.blocProgress,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [items, blocProgress, errorMessage];
}
