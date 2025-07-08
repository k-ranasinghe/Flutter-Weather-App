import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/global_controller.dart';
import 'package:weather_app/model/weather_data_current.dart';
import 'package:weather_app/utils/custom_colors.dart';
import 'package:weather_app/widgets/comfort_level_widget.dart';
import 'package:weather_app/widgets/current_weather_widget.dart';
import 'package:weather_app/widgets/daily_data_widget.dart';
import 'package:weather_app/widgets/header_widget.dart';
import 'package:weather_app/widgets/hourly_data_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController = Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => globalController.checkLoading().isTrue
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/four-seasons.png",
                      height: 200,
                      width: 200,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Weather App',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                        letterSpacing: 2.0,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              )
            : Center(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const SizedBox(height: 20),
                  const HeaderWidget(),
                  CurrentWeatherWidget(weatherDataCurrent: globalController.getWeatherData().getCurrentWeather()),
                  const SizedBox(height: 20),
                  HourlyDataWidget(weatherDataHourly: globalController.getWeatherData().getHourlyWeather()),
                  DailyDataWidget(weatherDataDaily: globalController.getWeatherData().getDailyWeather()),
                  Container(
                    height: 1,
                    color: CustomColors.dividerLine,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ComfortLevelWidget(weatherDataCurrent: globalController.getWeatherData().getCurrentWeather()),
                ]
              ),
            )),
      ),
    );
  }
}