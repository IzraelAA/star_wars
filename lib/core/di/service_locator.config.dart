// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:star_wars/feature/home/data/data_sources/star_wars_data_source.dart'
    as _i3;
import 'package:star_wars/feature/home/data/repositories/star_wars_repository.dart'
    as _i5;
import 'package:star_wars/feature/home/domain/repositories/star_wars_repository.dart'
    as _i4;
import 'package:star_wars/feature/home/domain/use_cases/get_home_world.dart'
    as _i6;
import 'package:star_wars/feature/home/domain/use_cases/get_people.dart' as _i7;
import 'package:star_wars/feature/home/domain/use_cases/get_starship.dart'
    as _i8;
import 'package:star_wars/feature/home/domain/use_cases/get_vehicles.dart'
    as _i9;
import 'package:star_wars/feature/home/presentation/manager/detail_home_cubit/detail_home_cubit.dart'
    as _i11;
import 'package:star_wars/feature/home/presentation/manager/home_manager_cubit.dart'
    as _i10;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.StarWarsDataSource>(() => _i3.StarWarsDatSourceImpl());
  gh.factory<_i4.StarWarsRepository>(() => _i5.StarWarsRepositoryImpl(
      starWarsDataSource: gh<_i3.StarWarsDataSource>()));
  gh.lazySingleton<_i6.GetHomeWorld>(
      () => _i6.GetHomeWorld(gh<_i4.StarWarsRepository>()));
  gh.lazySingleton<_i7.GetPeople>(
      () => _i7.GetPeople(gh<_i4.StarWarsRepository>()));
  gh.lazySingleton<_i8.GetStarship>(
      () => _i8.GetStarship(gh<_i4.StarWarsRepository>()));
  gh.lazySingleton<_i9.GetVehicles>(
      () => _i9.GetVehicles(gh<_i4.StarWarsRepository>()));
  gh.lazySingleton<_i10.HomeManagerCubit>(
      () => _i10.HomeManagerCubit(gh<_i7.GetPeople>()));
  gh.lazySingleton<_i11.DetailHomeCubit>(() => _i11.DetailHomeCubit(
        gh<_i8.GetStarship>(),
        gh<_i9.GetVehicles>(),
        gh<_i6.GetHomeWorld>(),
      ));
  return getIt;
}
