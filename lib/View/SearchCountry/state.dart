import 'package:covid_19_tracker_bloc_clean_architecture/Api/api_response.dart';

abstract class CountriesState {}

class WrapperCountriesState<T> extends CountriesState {
  final ApiResponse<T> apiResponse;
  WrapperCountriesState(this.apiResponse);
}
