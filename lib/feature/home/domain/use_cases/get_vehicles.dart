import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:star_wars/core/error/failures.dart';
import 'package:star_wars/core/usecases/usecase.dart';
import 'package:star_wars/feature/home/domain/entities/transportation_model.dart';
import 'package:star_wars/feature/home/domain/repositories/star_wars_repository.dart';

@LazySingleton()
class GetVehicles extends UseCase<TransportationModel, String> {
  final StarWarsRepository starWarsRepository;

  GetVehicles(this.starWarsRepository);

  @override
  Future<Either<Failure, TransportationModel>> call(String params) async {
    print(params);
    return await starWarsRepository.getTransportation(params);
  }
}
