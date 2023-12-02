import 'dart:async';
import 'dart:math';

import 'package:covid_19_tracker_bloc_clean_architecture/Utils/images.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Utils/routes.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Utils/text_style.dart';
import 'package:covid_19_tracker_bloc_clean_architecture/Widget/sized_box.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat();

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.popAndPushNamed(context, MyRoutes.kHome),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _appLogo(height),
                    addVerticalSpace(height * 0.06),
                    _appTitleText(context, height),
                  ],
                ),
              ),
              _allRightsReservedText(height, context),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedBuilder _appLogo(double height) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animationController.value * (2 * pi),
          child: Image.asset(
            MyImages.kVirus,
            height: height * 0.20,
            width: height * 0.20,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Text _appTitleText(BuildContext context, double height) {
    return Text(
      "Covid-19\nTracker App",
      style: MyFontStyle.kDisplayMedium,
      textAlign: TextAlign.center,
    );
  }

  Padding _allRightsReservedText(double height, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.012),
      child: Text(
        "\u00a9 All Rights Reserved",
        style: MyFontStyle.kBodySmall,
      ),
    );
  }
}
