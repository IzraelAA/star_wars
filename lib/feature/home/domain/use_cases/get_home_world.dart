import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:star_wars/core/error/failures.dart';
import 'package:star_wars/core/usecases/usecase.dart';
import 'package:star_wars/feature/home/domain/entities/planet_model.dart';
import 'package:star_wars/feature/home/domain/repositories/star_wars_repository.dart';

@LazySingleton()
class GetHomeWorld extends UseCase<PlanetModel, String> {
  final StarWarsRepository starWarsRepository;

  GetHomeWorld(this.starWarsRepository);

  @override
  Future<Either<Failure, PlanetModel>> call(String params) async {
    return await starWarsRepository.getPlanet(params);
  }
}
