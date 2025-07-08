import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_app/model/weather_data_current.dart';
import 'package:weather_app/utils/custom_colors.dart';
import 'package:intl/intl.dart';

class ComfortLevelWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  const ComfortLevelWidget({Key? key, required this.weatherDataCurrent}) : super(key: key);

  String getTime(int timestamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final formattedTime = DateFormat('HH:mm').format(time); // Format as HH:mm
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 1, left: 20, right: 20, bottom: 20),
          child: const Text(
            "Comfort Level",
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
          height: 230,
          child: Column(
            children: [
              Center(
                child: SleekCircularSlider(
                  min: 0,
                  max: 100,
                  initialValue: weatherDataCurrent.main.humidity.toDouble(),
                  appearance: CircularSliderAppearance(
                    customWidths: CustomSliderWidths(
                      handlerSize: 0,
                      trackWidth: 12,
                      progressBarWidth: 12
                    ),
                    infoProperties: InfoProperties(
                      bottomLabelText: "Humidity",
                      bottomLabelStyle: const TextStyle(
                          fontSize: 14, letterSpacing: 0.1, height: 1.5),
                    ),
                    animationEnabled: true,
                    size: 140,
                    customColors: CustomSliderColors(
                      hideShadow: true,
                      trackColor: CustomColors.firstGradientColor.withAlpha(100),
                      progressBarColors: [
                        CustomColors.firstGradientColor,
                        CustomColors.secondGradientColor
                      ]
                    )
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Feels Like",
                        style: TextStyle(
                          fontSize: 14,
                          color: CustomColors.textColorBlack,
                          height: 0.8,
                          fontWeight: FontWeight.w400
                        )
                      ),
                      TextSpan(
                          text: " ${weatherDataCurrent.main.feelsLike.toInt()}°C",
                          style: TextStyle(
                              fontSize: 14,
                              color: CustomColors.textColorBlack,
                              height: 0.8,
                              fontWeight: FontWeight.w400
                          )
                      )
                    ]
                  )),
                  Container(
                    height: 25,
                    width: 1,
                    color: CustomColors.dividerLine,
                    margin: const EdgeInsets.only(left: 40, right: 40),
                  ),
                  RichText(text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Gust",
                            style: TextStyle(
                                fontSize: 14,
                                color: CustomColors.textColorBlack,
                                height: 0.8,
                                fontWeight: FontWeight.w400
                            )
                        ),
                        TextSpan(
                            text: " ${weatherDataCurrent.wind.gust} km/h",
                            style: TextStyle(
                                fontSize: 14,
                                color: CustomColors.textColorBlack,
                                height: 0.8,
                                fontWeight: FontWeight.w400
                            )
                        )
                      ]
                  )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icons/sunrise.png",
                        height: 40,
                        width: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 2), // Set padding here
                        child: Text(
                          getTime(weatherDataCurrent.sys.sunrise),
                          style: TextStyle(
                            fontSize: 14,
                            color: CustomColors.textColorBlack,
                            height: 0.8,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 25,
                    width: 1,
                    margin: const EdgeInsets.only(left: 80, right: 80),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icons/sunset.png",
                        height: 40,
                        width: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 2), // Set padding here
                        child: Text(
                          getTime(weatherDataCurrent.sys.sunset),
                          style: TextStyle(
                            fontSize: 14,
                            color: CustomColors.textColorBlack,
                            height: 0.8,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
