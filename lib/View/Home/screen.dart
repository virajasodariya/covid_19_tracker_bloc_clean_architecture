import 'package:covid_19_tracker_bloc_clean_architecture/Api/api_response.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Model/all_response_model.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Utils/colors.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Utils/routes.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Utils/text_style.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/Home/state.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/Home/cubit.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Widget/api_calling_status.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Widget/format_indian_number.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Widget/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<AllCubit>(context).getAllCountriesData();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: _buildAppBar(context, height),
      body: _buildBody(height),
    );
  }

  Center _buildBody(double height) {
    return Center(
      child: BlocBuilder<AllCubit, AllState>(
        builder: (context, state) {
          if (state is WrapperAllState) {
            var apiResponse = state.apiResponse;
            if (apiResponse.status == Status.LOADING) {
              return ApiResponseStatus.loadingStatus();
            } else if (apiResponse.status == Status.COMPLETE) {
              AllResponseModel data = apiResponse.data;
              return _buildCompleteState(height, context, data);
            } else if (apiResponse.status == Status.ERROR) {
              return ApiResponseStatus.errorStatus(apiResponse);
            } else {
              return ApiResponseStatus.elseStatus();
            }
          } else {
            return ApiResponseStatus.unknownState();
          }
        },
      ),
    );
  }

  Padding _buildCompleteState(
      double height, BuildContext context, AllResponseModel data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: height * 0.015),
      child: Column(
        children: [
          _buildHeader(height, context, data),
          const Expanded(flex: 5, child: SizedBox()),
          _buildHeading(height),
          _buildReportDetails(height, data),
          _buildCountryButton(height),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, double height) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Covid-19 Tracker',
        style: MyFontStyle.kDisplayMedium,
      ),
    );
  }

  Expanded _buildReportDetails(double height, AllResponseModel data) {
    return Expanded(
      flex: 60,
      child: Container(
        margin: EdgeInsets.all(height * 0.015),
        padding: EdgeInsets.symmetric(
            vertical: height * 0.015, horizontal: height * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height * 0.03),
          border: Border.all(color: MyColors.kLoblolly, width: 1.0),
        ),
        child: SingleChildScrollView(
          child: Column(
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
              _buildReportItem(
                  "Cases Per One Million", data.casesPerOneMillion),
              _addHorizontalDivider(height),
              _buildReportItem(
                  "Deaths Per One Million", data.deathsPerOneMillion),
              _addHorizontalDivider(height),
              _buildReportItem("Tests", data.tests),
              _addHorizontalDivider(height),
              _buildReportItem(
                  "Tests Per One Million", data.testsPerOneMillion),
              _addHorizontalDivider(height),
              _buildReportItem("Population", data.population),
              _addHorizontalDivider(height),
              _buildReportItem(
                  "Active Per One Million", data.activePerOneMillion),
              _addHorizontalDivider(height),
              _buildReportItem(
                  "Recovered Per One Million", data.recoveredPerOneMillion),
              _addHorizontalDivider(height),
              _buildReportItem(
                  "Critical Per One Million", data.criticalPerOneMillion),
              _addHorizontalDivider(height),
              _buildReportItem("Affected Countries", data.affectedCountries),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildHeader(
      double height, BuildContext context, AllResponseModel data) {
    return Expanded(
      flex: 20,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: height * 0.015,
              left: height * 0.015,
              right: height * 0.015,
            ),
            padding: EdgeInsets.only(bottom: height * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height * 0.03),
              border: Border.all(color: MyColors.kLoblolly, width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeaderTitle(
                    context, height, "Cases", formatIndianNumber(data.cases)),
                _buildVerticalDivider(height),
                _buildHeaderTitle(context, height, "Recovered",
                    formatIndianNumber(data.recovered)),
                _buildVerticalDivider(height),
                _buildHeaderTitle(
                    context, height, "Deaths", formatIndianNumber(data.deaths)),
              ],
            ),
          ),
          Positioned(
            bottom: -(height * 0.03),
            right: 0.0,
            left: 0.0,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: height * 0.03,
              child: ClipOval(
                child: Image.network(
                  "https://cdn.pixabay.com/photo/2015/04/19/08/32/rose-729509_640.jpg",
                  width: height * 0.06,
                  height: height * 0.06,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildCountryButton(double height) {
    return Expanded(
      flex: 12,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.018,
          horizontal: height * 0.01,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: height * 0.015),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.kSearchCountryScreen);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: MyColors.kPorcelain,
              backgroundColor: MyColors.kCodGray,
              enableFeedback: true,
              fixedSize: const Size.fromWidth(double.infinity),
            ),
            child: Text(
              'Track Countries',
              style: MyFontStyle.kHeadlineMedium
                  .copyWith(color: MyColors.kPorcelain),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildHeading(double height) {
    return Container(
      margin: EdgeInsets.only(
        top: height * 0.02,
        left: height * 0.01,
        right: height * 0.01,
      ),
      padding: EdgeInsets.only(left: height * 0.01),
      alignment: Alignment.centerLeft,
      child: Text(
        "'World Reports",
        style: MyFontStyle.kDisplaySmall,
      ),
    );
  }

  ListTile _buildReportItem(String text, num? count) {
    return ListTile(
      title: _buildReportText(text),
      trailing: _buildReportText(formatIndianNumber(count)),
    );
  }

  Text _buildReportText(String text) {
    return Text(
      text,
      style: MyFontStyle.kHeadlineMedium,
    );
  }

  Divider _addHorizontalDivider(double height) {
    return Divider(
      color: MyColors.kLoblollyLight,
      thickness: 1.0,
      indent: height * 0.08,
      endIndent: height * 0.08,
    );
  }

  VerticalDivider _buildVerticalDivider(double height) {
    return VerticalDivider(
      color: MyColors.kLoblolly,
      thickness: 1.0,
      indent: height * 0.035,
      endIndent: height * 0.035,
    );
  }

  Expanded _buildHeaderTitle(
      BuildContext context, double height, String text, String count) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: MyFontStyle.kTitleLarge,
          ),
          addVerticalSpace(height * 0.01),
          Text(
            count,
            style: MyFontStyle.kHeadlineMedium,
          ),
        ],
      ),
    );
  }
}
