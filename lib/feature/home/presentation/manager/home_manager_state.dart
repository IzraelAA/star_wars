part of 'home_manager_cubit.dart';

class HomeState extends Equatable {
  final StatusState statusState;
  final List<PeopleModel>? data;

  const HomeState({
    required this.statusState,
    required this.data,
  });

  @override
  List<Object?> get props => [statusState, data];

  HomeState copyWith({
    final StatusState? statusState,
    final List<PeopleModel>? data,
  }) {
    return HomeState(
      statusState: statusState ?? this.statusState,
      data: data ?? this.data,
    );
  }
}
