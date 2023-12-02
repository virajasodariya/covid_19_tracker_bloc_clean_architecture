import 'package:covid_19_tracker_bloc_clean_architecture/Service/bloc_provider.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Utils/routes.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: allBlocProvider,
      child: MaterialApp(
        title: 'Covid-19 Tracker',
        debugShowCheckedModeBanner: false,
        theme: covidTheme,
        routes: routes,
        initialRoute: MyRoutes.kSplashScreen,
      ),
    );
  }
}
