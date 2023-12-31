
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:star_wars/core/constant/status_state.dart';
import 'package:star_wars/core/local_database/shared_preferences.dart';
import 'package:star_wars/feature/home/domain/entities/people_model.dart';
import 'package:star_wars/feature/home/domain/use_cases/get_people.dart';

part 'home_manager_state.dart';

@LazySingleton()
/// Cubit managing the state for the home screen in the Star Wars app.
class HomeManagerCubit extends Cubit<HomeState> {
  HomeManagerCubit(
      this.getPeople,
      ) : super(const HomeState(
    statusState: StatusState.initial,
    data: null,
  ));

  final GetPeople getPeople;
  int page = 1;
  String name = "";

  /// Initialize the data, either by fetching from the local database or making an API call.
  void initialData() async {
    emit(state.copyWith(statusState: StatusState.loaded));
    page = 1;
    name = "";
    var data = await StarWarsLocalDatabase().getPeopleData();
    if (data.isNotEmpty) {
      emit(
        state.copyWith(
          statusState: StatusState.loaded,
          data: data,
        ),
      );
    } else {
      var res = await getPeople(ParamsPeople());
      res.fold(
            (l) => emit(state.copyWith(
          statusState: StatusState.error,
        )),
            (r) async {
          await StarWarsLocalDatabase().setPeopleData(r.data);
          return emit(
            state.copyWith(
              statusState: StatusState.loaded,
              data: r.data,
            ),
          );
        },
      );
    }
  }

  /// Load more data as the user scrolls.
  void loadData(List<PeopleModel> model) async {
    page++;
    emit(state.copyWith(statusState: StatusState.loading));
    var res = await getPeople(ParamsPeople(name: name, next: page));
    res.fold(
          (l) => emit(state.copyWith(
        statusState: StatusState.error,
      )),
          (r) async {
        model.addAll(r.data);
        return emit(
          state.copyWith(
            statusState: StatusState.loaded,
            data: model,
          ),
        );
      },
    );
  }

  /// Search for a character by name and update the state accordingly.
  void searchCharacter(String name) async {
    emit(state.copyWith(statusState: StatusState.loading, data: []));

    var res = await getPeople(ParamsPeople(name: name));
    res.fold(
          (l) => emit(state.copyWith(
        statusState: StatusState.error,
      )),
          (r) async {
        await StarWarsLocalDatabase().setPeopleData(r.data);
        return emit(
          state.copyWith(
            statusState: StatusState.loaded,
            data: r.data,
          ),
        );
      },
    );
  }
}
