import 'package:covid_19_tracker_bloc_clean_architecture/Api/api_response.dart';
import 'package:flutter/material.dart';

class ApiResponseStatus {
  static Center loadingStatus() =>
      const Center(child: CircularProgressIndicator(color: Colors.black));

  static Center errorStatus(ApiResponse<dynamic> apiResponse) => Center(
        child: Text(
            "Oops! Something went wrong. \nPlease try again later. \nIf the problem persists, contact support. \nError: ${apiResponse.message}",
            textAlign: TextAlign.center),
      );

  static Center elseStatus() => const Center(
        child: Text(
            "Unexpected error occurred. \nPlease try reloading the page.",
            textAlign: TextAlign.center),
      );

  static Center unknownState() => const Center(
        child: Text(
            "We're facing some issues. \nPlease try again later or contact support if the problem continues.",
            textAlign: TextAlign.center),
      );
}
