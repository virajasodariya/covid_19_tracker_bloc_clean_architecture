import 'package:covid_19_tracker_bloc_clean_architecture/Api/api_response.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Service/api_calling_status.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Utils/colors.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Utils/text_style.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/MasterCountry/Bloc/bloc.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/MasterCountry/Bloc/event.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/MasterCountry/Bloc/state.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/MasterCountry/Model/master_country_response_model.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/Widget/format_indian_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MasterCountryScreen extends StatefulWidget {
  const MasterCountryScreen({Key? key}) : super(key: key);

  @override
  State<MasterCountryScreen> createState() => _MasterCountryScreenState();
}

class _MasterCountryScreenState extends State<MasterCountryScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    BlocProvider.of<MasterCountryBloc>(context)
        .add(FetchDataEvent("${args["countryName"]}"));

    return Scaffold(
      appBar: _buildAppBar(args, context, height),
      body: _buildBody(height),
    );
  }

  AppBar _buildAppBar(
      Map<dynamic, dynamic> args, BuildContext context, double height) {
    return AppBar(
      title: Text(
        "${args["countryName"]}",
        style: MyFontStyle.kDisplayMedium,
      ),
      automaticallyImplyLeading: true,
      centerTitle: true,
    );
  }

  BlocBuilder<MasterCountryBloc, MasterCountryState> _buildBody(double height) {
    return BlocBuilder<MasterCountryBloc, MasterCountryState>(
      builder: (context, state) {
        if (state is WrapperMasterCountryState) {
          var apiResponse = state.apiResponse;
          if (apiResponse.status == Status.LOADING) {
            return ApiResponseStatus.loadingStatus();
          } else if (apiResponse.status == Status.COMPLETE) {
            MasterCountryResponseModel data = apiResponse.data;
            return _buildCompleteState(height, data);
          } else if (apiResponse.status == Status.ERROR) {
            return ApiResponseStatus.errorStatus(apiResponse);
          } else {
            return ApiResponseStatus.elseStatus();
          }
        } else {
          return ApiResponseStatus.unknownState();
        }
      },
    );
  }

  Padding _buildCompleteState(double height, MasterCountryResponseModel data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: height * 0.03),
      child: Column(
        children: [
          const Expanded(flex: 15, child: SizedBox()),
          _buildReportDetails(height, data),
          const Expanded(flex: 15, child: SizedBox()),
        ],
      ),
    );
  }

  Expanded _buildReportDetails(double height, MasterCountryResponseModel data) {
    return Expanded(
      flex: 70,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: height * 0.065,
              bottom: height * 0.015,
              left: height * 0.03,
              right: height * 0.03,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height * 0.03),
              border: Border.all(color: MyColors.kLoblolly, width: 1.0),
            ),
            child: _buildReportItems(data, height),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: -(height * 0.05),
            child: CircleAvatar(
              radius: height * 0.05,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.network(
                  "${data.countryInfo!.flag}",
                  width: height * 0.1,
                  height: height * 0.1,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ListView _buildReportItems(MasterCountryResponseModel data, double height) {
    return ListView(
      children: [
        _buildReportItem("Updated", data.updated),
        _addHorizontalDivider(height),
        _buildReportItem("Cases", data.cases),
        _addHorizontalDivider(height),
        _buildReportItem("Today Cases", data.todayCases),
        _addHorizontalDivider(height),
        _buildReportItem("Deaths", data.deaths),
        _addHorizontalDivider(height),
        _buildReportItem("Today Deaths", data.todayDeaths),
        _addHorizontalDivider(height),
        _buildReportItem("Recovered", data.recovered),
        _addHorizontalDivider(height),
        _buildReportItem("Today Recovered", data.todayRecovered),
        _addHorizontalDivider(height),
        _buildReportItem("Active", data.active),
        _addHorizontalDivider(height),
        _buildReportItem("Critical", data.critical),
        _addHorizontalDivider(height),
        _buildReportItem("Cases Per One Million", data.casesPerOneMillion),
        _addHorizontalDivider(height),
        _buildReportItem("Deaths Per One Million", data.deathsPerOneMillion),
        _addHorizontalDivider(height),
        _buildReportItem("Tests", data.tests),
        _addHorizontalDivider(height),
        _buildReportItem("Tests Per One Million", data.testsPerOneMillion),
        _addHorizontalDivider(height),
        _buildReportItem("Population", data.population),
        _addHorizontalDivider(height),
        _buildReportItem("Active Per One Million", data.activePerOneMillion),
        _addHorizontalDivider(height),
        _buildReportItem(
            "Recovered Per One Million", data.recoveredPerOneMillion),
        _addHorizontalDivider(height),
        _buildReportItem(
            "Critical Per One Million", data.criticalPerOneMillion),
      ],
    );
  }

  Widget _buildReportItem(String title, num? count) {
    return ListTile(
      title: _buildReportText(title),
      trailing: _buildReportText(formatIndianNumber(count)),
    );
  }

  Widget _buildReportText(String text) {
    return Text(
      text,
      style: MyFontStyle.kHeadlineMedium,
    );
  }

  Widget _addHorizontalDivider(double height) {
    return Divider(
      color: MyColors.kLoblollyLight,
      thickness: 1.0,
      indent: height * 0.08,
      endIndent: height * 0.08,
    );
  }
}
