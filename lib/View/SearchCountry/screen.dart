import 'package:covid_19_tracker_bloc_clean_architecture/Api/api_response.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Model/countries_response_model.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Utils/colors.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Utils/routes.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Utils/text_style.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/SearchCountry/bloc.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/SearchCountry/event.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/View/SearchCountry/state.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Widget/api_calling_status.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Widget/format_indian_number.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Widget/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCountryScreen extends StatefulWidget {
  const SearchCountryScreen({super.key});

  @override
  State<SearchCountryScreen> createState() => _SearchCountryScreenState();
}

class _SearchCountryScreenState extends State<SearchCountryScreen> {
  TextEditingController searchCountry = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CountriesBloc>(context).add(CountriesFetchDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(height, width),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Track Country',
        style: MyFontStyle.kDisplayMedium,
      ),
    );
  }

  BlocBuilder<CountriesBloc, CountriesState> _buildBody(
      double height, double width) {
    return BlocBuilder<CountriesBloc, CountriesState>(
      builder: (context, state) {
        if (state is WrapperCountriesState) {
          var apiResponse = state.apiResponse;
          if (apiResponse.status == Status.LOADING) {
            return ApiResponseStatus.loadingStatus();
          } else if (apiResponse.status == Status.COMPLETE) {
            List<CountriesResponseModel> data = apiResponse.data;

            List<CountriesResponseModel> filteredData =
                searchCountry.text.isEmpty
                    ? data
                    : data
                        .where((item) => item.country!
                            .toLowerCase()
                            .contains(searchCountry.text.toLowerCase()))
                        .toList();

            return _buildCompleteState(height, filteredData, width);
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

  Padding _buildCompleteState(
      double height, List<CountriesResponseModel> data, double width) {
    return Padding(
      padding: EdgeInsets.only(
        left: height * 0.03,
        right: height * 0.03,
        top: height * 0.03,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTextField(),
          addVerticalSpace(height * 0.015),
          _mainListView(data, height, width),
        ],
      ),
    );
  }

  Expanded _mainListView(
      List<CountriesResponseModel> data, double height, double width) {
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Container(
            height: height * 0.1,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.only(top: height * 0.015),
            decoration: BoxDecoration(
              color: MyColors.kCodGray,
              borderRadius: BorderRadius.circular(height * 0.03),
              border: Border.all(color: MyColors.kCodGray, width: 1.0),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    width: constraints.maxWidth * 0.97,
                    decoration: BoxDecoration(
                      color: MyColors.kPorcelain,
                      borderRadius: BorderRadius.circular(height * 0.03),
                      border: Border.all(color: MyColors.kCodGray, width: 0.2),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Material(
                      color: MyColors.kPorcelain,
                      child: ListTile(
                        splashColor: MyColors.kWhite,
                        onTap: () {
                          Navigator.pushNamed(
                              context, MyRoutes.kMasterCountryScreen,
                              arguments: {
                                'countryName': "${data[index].country}"
                              });
                        },
                        leading: CircleAvatar(
                          radius: height * 0.03,
                          backgroundColor: MyColors.kPorcelain,
                          child: ClipOval(
                            child: Image.network(
                              "${data[index].countryInfo!.flag}",
                              width: height * 0.06,
                              height: height * 0.06,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          "${data[index].country}",
                          style: MyFontStyle.kHeadlineMedium,
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          "Effected: ${formatIndianNumber(data[index].active)}",
                          style: MyFontStyle.kTitleLarge,
                        ),
                        trailing: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  TextField _buildTextField() {
    return TextField(
      controller: searchCountry,
      onChanged: (String? value) {
        setState(() {});
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(
            color: MyColors.kCodGray,
            width: 1.0,
          ),
        ),
        enabled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(
            color: MyColors.kBlack,
            width: 1.0,
          ),
        ),
        hintText: 'Search with country name',
        suffixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(
            color: MyColors.kBlack,
            width: 1.0,
          ),
        ),
      ),
      cursorColor: MyColors.kBlack,
    );
  }
}
