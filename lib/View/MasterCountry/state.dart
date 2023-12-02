import 'package:covid_19_tracker_bloc_clean_architecture/Api/api_response.dart';

abstract class MasterCountryState {}

class WrapperMasterCountryState<T> extends MasterCountryState {
  final ApiResponse<T> apiResponse;
  WrapperMasterCountryState(this.apiResponse);
}
