import 'dart:developer';

import 'package:covid_19_tracker_bloc_clean_architecture/Api/api_handlers.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Api/base_url.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Model/all_response_model.dart';

class AllCountriesRepo {
  static Future<AllResponseModel> getAllCountriesData() async {
    String url = "${BaseUrl.kBaseUrl}${EndPoint.kAll}";
    // log("ALL COUNTRIES URL : $url");

    var apiResponse = await APIService().getResponse(
      url: url,
      apiType: APIType.aGet,
    );

    AllResponseModel responseData = AllResponseModel.fromJson(apiResponse);

    return responseData;
  }
}
