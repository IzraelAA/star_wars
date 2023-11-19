import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:star_wars/core/error/failures.dart';
import 'package:star_wars/core/network/parser_json.dart';
import 'package:star_wars/feature/home/data/data_sources/star_wars_data_source.dart';
import 'package:star_wars/feature/home/domain/entities/people_model.dart';
import 'package:star_wars/feature/home/domain/entities/planet_model.dart';
import 'package:star_wars/feature/home/domain/entities/transportation_model.dart';
import 'package:star_wars/feature/home/domain/repositories/star_wars_repository.dart';
import 'package:star_wars/feature/home/domain/use_cases/get_people.dart';

/// Implementation of [StarWarsRepository] that interacts with [StarWarsDataSource] to fetch data.
@Injectable(as: StarWarsRepository)
class StarWarsRepositoryImpl extends StarWarsRepository {
  final StarWarsDataSource starWarsDataSource;

  StarWarsRepositoryImpl({required this.starWarsDataSource});

  /// Fetch a list of people from the Star Wars universe.
  @override
  Future<Either<Failure, ParserJson<List<PeopleModel>>>> people(
      ParamsPeople paramsPeople) async {
    try {
      var result = await starWarsDataSource.getPeopleData(paramsPeople);
      return Right(result);
    } catch (ex) {
      return Left(ServerFailure());
    }
  }

  /// Fetch transportation details using the provided endpoint.
  @override
  Future<Either<Failure, TransportationModel>> getTransportation(
      String endpoint) async {
    try {
      var result = await starWarsDataSource.getTransportation(endpoint);
      return Right(result);
    } catch (ex) {
      return Left(ServerFailure());
    }
  }

  /// Fetch planet details using the provided endpoint.
  @override
  Future<Either<Failure, PlanetModel>> getPlanet(String endpoint) async {
    try {
      var result = await starWarsDataSource.getHomeWorld(endpoint);
      return Right(result);
    } catch (ex) {
      return Left(ServerFailure());
    }
  }
}
