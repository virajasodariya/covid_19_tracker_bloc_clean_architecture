import 'dart:developer';

import 'package:covid_19_tracker_bloc_clean_architecture/Api/api_response.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Bloc/SearchCountryBloc/event.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Bloc/SearchCountryBloc/state.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Repository/countries_repo.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Model/countries_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  CountriesBloc() : super(WrapperCountriesState(ApiResponse.initial())) {
    on<CountriesFetchDataEvent>((event, emit) => fetchData(emit));
  }

  Future<void> fetchData(Emitter<CountriesState> emit) async {
    try {
      emit(WrapperCountriesState(ApiResponse.loading()));

      List<CountriesResponseModel> response =
          await CountriesRepo.getAllCountries();

      // log("COUNTRIES REPO RESPONSE ======== $response");

      emit(WrapperCountriesState(ApiResponse.complete(response)));
    } catch (error) {
      log('Error fetching data: $error');

      emit(WrapperCountriesState(ApiResponse.error(message: error.toString())));
    }
  }
}
