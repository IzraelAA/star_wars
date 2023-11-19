import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:star_wars/core/error/failures.dart';
import 'package:star_wars/core/network/parser_json.dart';
import 'package:star_wars/core/usecases/usecase.dart';
import 'package:star_wars/feature/home/domain/entities/people_model.dart';
import 'package:star_wars/feature/home/domain/repositories/star_wars_repository.dart';

@LazySingleton()
class GetPeople extends UseCase<ParserJson<List<PeopleModel>>, ParamsPeople> {
  final StarWarsRepository starWarsRepository;

  GetPeople(this.starWarsRepository);

  @override
  Future<Either<Failure, ParserJson<List<PeopleModel>>>> call(
      ParamsPeople params) async {
    return await starWarsRepository.people(params);
  }
}

class ParamsPeople {
  final String name;
  final int next;

  ParamsPeople({this.name="", this.next = 1});
}
