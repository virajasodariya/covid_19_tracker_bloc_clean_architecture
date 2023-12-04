import 'package:covid_19_tracker_bloc_clean_architecture/View/Home/View/screen.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/MasterCountry/View/screen.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/SearchCountry/View/screen.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/Splash/View/screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  MyRoutes.kSplashScreen: (_) => const SplashScreen(),
  MyRoutes.kHome: (_) => const HomeScreen(),
  MyRoutes.kSearchCountryScreen: (_) => const SearchCountryScreen(),
  MyRoutes.kMasterCountryScreen: (_) => const MasterCountryScreen(),
};

class MyRoutes {
  static const String kSplashScreen = '/';
  static const String kHome = '/home';
  static const String kMasterCountryScreen = '/master-country';
  static const String kSearchCountryScreen = '/search-country';
}
