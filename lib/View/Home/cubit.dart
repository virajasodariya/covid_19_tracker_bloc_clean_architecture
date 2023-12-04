import 'dart:developer';

import 'package:covid_19_tracker_bloc_clean_architecture/Api/api_response.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Model/all_response_model.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Repo/all_repo.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/Home/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCubit extends Cubit<AllState> {
  AllCubit() : super(WrapperAllState(ApiResponse.initial()));

  Future<void> getAllCountriesData() async {
    try {
      emit(WrapperAllState(ApiResponse.loading()));

      AllResponseModel response = await AllCountriesRepo.getAllCountriesData();

      // log("ALL COUNTRIES REPO RESPONSE ======== $response");

      emit(WrapperAllState(ApiResponse.complete(response)));
    } catch (error) {
      log('Error fetching data: $error');

      emit(WrapperAllState(ApiResponse.error(message: error.toString())));
    }
  }
}
