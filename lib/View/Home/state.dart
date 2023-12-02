import 'package:covid_19_tracker_bloc_clean_architecture/Api/api_response.dart';

abstract class AllState {}

class WrapperAllState<T> extends AllState {
  final ApiResponse<T> apiResponse;
  WrapperAllState(this.apiResponse);
}
