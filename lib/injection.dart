import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars/feature/home/presentation/manager/detail_home_cubit/detail_home_cubit.dart';
import 'package:star_wars/feature/home/presentation/manager/home_manager_cubit.dart';

import 'core/di/service_locator.dart';

class Injection {
  Injection._privateConstructor();

  static final Injection _instance = Injection._privateConstructor();

  static Injection get instance => _instance;

  //----------------------- BLoC Initialization -----------------------//
  List<BlocProvider> initBloc() => [
    BlocProvider<HomeManagerCubit>(
      create: (context) => getIt<HomeManagerCubit>()..initialData(),
    ),
    BlocProvider<DetailHomeCubit>(
      create: (context) => getIt<DetailHomeCubit>(),
    ),
  ];

}
