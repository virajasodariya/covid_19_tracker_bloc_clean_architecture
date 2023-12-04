import 'package:covid_19_tracker_bloc_clean_architecture/Bloc/HomeBloc/cubit.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Bloc/MasterCountryBloc/bloc.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Bloc/SearchCountryBloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> allBlocProvider = [
  BlocProvider<AllCubit>(create: (_) => AllCubit()),
  BlocProvider<CountriesBloc>(create: (_) => CountriesBloc()),
  BlocProvider<MasterCountryBloc>(create: (_) => MasterCountryBloc()),
];
