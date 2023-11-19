part of 'detail_home_cubit.dart';


class DetailHomeState extends Equatable {
  final StatusState statusStarship;
  final List<TransportationModel> starshipModel;
  final List<TransportationModel> vehiclesModel;
  final PlanetModel? homeWorld;
  final StatusState statusVehicles;
  final StatusState statusHomeWorld;

  const DetailHomeState({
    required this.statusVehicles,
    required this.statusHomeWorld,
    required this.statusStarship,
    required this.starshipModel,
    required this.vehiclesModel,
    required this.homeWorld,
  });

  @override
  List<Object?> get props => [
        statusStarship,
        starshipModel,
        statusHomeWorld,
        statusVehicles,
        vehiclesModel,
        homeWorld,
      ];

  DetailHomeState copyWith({
    final StatusState? statusStarship,
    final List<TransportationModel>? starshipModel,
    final List<TransportationModel>? vehiclesModel,
    final StatusState? statusVehicles,
    final StatusState? statusHomeWorld,
    final PlanetModel? homeWorld,
  }) {
    return DetailHomeState(
      homeWorld: homeWorld ?? this.homeWorld,
      statusVehicles: statusVehicles ?? this.statusVehicles,
      statusHomeWorld: statusHomeWorld ?? this.statusHomeWorld,
      statusStarship: statusStarship ?? this.statusStarship,
      starshipModel: starshipModel ?? this.starshipModel,
      vehiclesModel: vehiclesModel ?? this.vehiclesModel,
    );
  }
}
