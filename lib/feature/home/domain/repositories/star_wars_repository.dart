import 'package:dartz/dartz.dart';
import 'package:star_wars/core/error/failures.dart';
import 'package:star_wars/core/network/parser_json.dart';
import 'package:star_wars/feature/home/domain/entities/people_model.dart';
import 'package:star_wars/feature/home/domain/entities/planet_model.dart';
import 'package:star_wars/feature/home/domain/entities/transportation_model.dart';
import 'package:star_wars/feature/home/domain/use_cases/get_people.dart';

abstract class StarWarsRepository {
  Future<Either<Failure, ParserJson<List<PeopleModel>>>> people(ParamsPeople paramsPeople);

  Future<Either<Failure, TransportationModel>> getTransportation(String endpoint);
  Future<Either<Failure, PlanetModel>> getPlanet(String endpoint);
}
