import 'dart:developer';

import 'package:covid_19_tracker_bloc_clean_architecture/Api/api_response.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Model/master_country_response_model.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Repo/master_country_repo.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/MasterCountry/event.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/MasterCountry/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MasterCountryBloc extends Bloc<MasterCountryEvent, MasterCountryState> {
  MasterCountryBloc()
      : super(WrapperMasterCountryState(ApiResponse.initial())) {
    on<FetchDataEvent>((event, emit) => fetchData(event, emit));
  }

  Future<void> fetchData(
      FetchDataEvent event, Emitter<MasterCountryState> emit) async {
    {
      String countryName = event.countryName;

      try {
        emit(WrapperMasterCountryState(ApiResponse.loading()));

        MasterCountryResponseModel response =
            await MasterCountryRepo.getSingleCountryData(countryName);

        // log("COUNTRIES REPO RESPONSE ======== $response");

        emit(WrapperMasterCountryState(ApiResponse.complete(response)));
      } catch (error) {
        log('Error fetching data: $error');

        emit(WrapperMasterCountryState(ApiResponse.error(message: "$error")));
      }
    }
  }
}
