import 'dart:convert';

import 'package:covid_19_tracker_bloc_clean_architecture/Api/api_handlers.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Api/base_url.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Model/countries_response_model.dart';

class CountriesRepo {
  static Future<List<CountriesResponseModel>> getAllCountries() async {
    String url = "${BaseUrl.kBaseUrl}${EndPoint.kCountries}";
    // log("COUNTRIES URL : $url");

    var apiResponse = await APIService().getResponse(
      url: url,
      apiType: APIType.aGet,
    );

    List<CountriesResponseModel> responseData =
        countriesResponseModelFromJson(jsonEncode(apiResponse));

    return responseData;
  }
}
