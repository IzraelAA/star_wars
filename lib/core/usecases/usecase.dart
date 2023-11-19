import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:star_wars/core/error/failures.dart';
import 'package:star_wars/core/network/parser_json.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoReturn extends Equatable {
  @override
  List<Object> get props => [];
}

class NoParamsV1 extends Equatable {
  @override
  List<Object> get props => [];
}
