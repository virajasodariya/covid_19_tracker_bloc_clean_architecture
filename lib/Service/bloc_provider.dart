import 'package:covid_19_tracker_bloc_clean_architecture/View/Home/Bloc/cubit.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/MasterCountry/Bloc/bloc.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/SearchCountry/Bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> allBlocProvider = [
  BlocProvider<AllCubit>(create: (_) => AllCubit()),
  BlocProvider<CountriesBloc>(create: (_) => CountriesBloc()),
  BlocProvider<MasterCountryBloc>(create: (_) => MasterCountryBloc()),
];
