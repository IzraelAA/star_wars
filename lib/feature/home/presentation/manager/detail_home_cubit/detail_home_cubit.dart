import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:star_wars/core/constant/status_state.dart';
import 'package:star_wars/core/network/api_url.dart';
import 'package:star_wars/feature/home/domain/entities/people_model.dart';
import 'package:star_wars/feature/home/domain/entities/planet_model.dart';
import 'package:star_wars/feature/home/domain/entities/transportation_model.dart';
import 'package:star_wars/feature/home/domain/use_cases/get_home_world.dart';
import 'package:star_wars/feature/home/domain/use_cases/get_starship.dart';
import 'package:star_wars/feature/home/domain/use_cases/get_vehicles.dart';

part 'detail_home_state.dart';

@LazySingleton()
class DetailHomeCubit extends Cubit<DetailHomeState> {
  DetailHomeCubit(
    this.getStarship,
    this.getVehicles,
    this.getHomeWorld,
  ) : super(const DetailHomeState(
            statusHomeWorld: StatusState.loading,
            statusStarship: StatusState.loading,
            statusVehicles: StatusState.loading,
            vehiclesModel: [],
            homeWorld: null,
            starshipModel: []));

  final GetStarship getStarship;
  final GetVehicles getVehicles;
  final GetHomeWorld getHomeWorld;

  void getDetailPeople(PeopleModel peopleModel) {
    emit(const DetailHomeState(
        statusHomeWorld: StatusState.loading,
        statusStarship: StatusState.loading,
        statusVehicles: StatusState.loading,
        homeWorld: null,
        vehiclesModel: [],
        starshipModel: []));
    starship(peopleModel, 0);
    vehicle(peopleModel, 0);
    homeWorld(peopleModel);
  }

  void starship(PeopleModel peopleModel, index) async {
    if (peopleModel.starships!.isNotEmpty) {
      List<TransportationModel> starshipModel = [];

      if (state.starshipModel.isNotEmpty) {
        starshipModel.addAll(state.starshipModel);
      }
      var url = peopleModel.starships?[index]
          .replaceFirst(RegExp(Endpoint.rawApi), '');
      var res = await getStarship(url!);

      res.fold((l) => "null", (r) {
        starshipModel.add(r);
      });
      emit(state.copyWith(
          statusStarship: StatusState.loaded, starshipModel: starshipModel));
    }
  }

  void vehicle(PeopleModel peopleModel, index) async {
    if (peopleModel.vehicles!.isNotEmpty) {
      List<TransportationModel> vehicles = [];

      if (state.vehiclesModel.isNotEmpty) {
        vehicles.addAll(state.vehiclesModel);
      }
      var url = peopleModel.vehicles![index]
          .replaceFirst(RegExp(Endpoint.rawApi), '');
      var res = await getVehicles(url);

      res.fold((l) => "null", (r) {
        print("check${r.name}");
        vehicles.add(r);
        emit(state.copyWith(
            statusVehicles: StatusState.loaded, vehiclesModel: vehicles));
      });
    }
  }

  void homeWorld(PeopleModel peopleModel) async {
    var res = await getHomeWorld(peopleModel.homeworld ?? "");

    res.fold((l) => "null", (r) {
      emit(state.copyWith(statusHomeWorld: StatusState.loaded, homeWorld: r));
    });
  }
}
