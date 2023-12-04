import 'dart:developer';

import 'package:covid_19_tracker_bloc_clean_architecture/Api/api_handlers.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Api/base_url.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Model/master_country_response_model.dart';

class MasterCountryRepo {
  static Future<MasterCountryResponseModel> getSingleCountryData(
      String countryName) async {
    String url = "${BaseUrl.kBaseUrl}${EndPoint.kCountries}/$countryName";
    // log("MASTER COUNTRY URL : $url");

    var apiResponse = await APIService().getResponse(
      url: url,
      apiType: APIType.aGet,
    );

    MasterCountryResponseModel responseData =
        MasterCountryResponseModel.fromJson(apiResponse);

    return responseData;
  }
}
