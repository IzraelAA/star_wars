import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:star_wars/core/di/service_locator.dart';
import 'package:star_wars/feature/home/presentation/pages/home_page.dart';
import 'package:star_wars/injection.dart';

// The main entry point for the Star Wars app.
// Configures dependencies and launches the app with the MyApp widget.
void main() {
  // Configuring dependencies using the service locator.
  configureDependencies();

  // Running the Star Wars app.
  runApp(const MyApp());
}

// The root widget of the Star Wars app.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Configuring screen utilities with a design size of 360x690.
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        // Setting the app title to 'Star Wars'.
        title: 'Star Wars',
        // Configuring the theme with Material 3 and a deep purple color scheme.
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        // Providing the home page wrapped with BLoC providers.
        home: MultiBlocProvider(
          providers: Injection.instance.initBloc(),
          child: const HomePage(),
        ),
      ),
    );
  }
}
