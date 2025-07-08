import 'dart:convert';
import 'package:weather_app/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_data_current.dart';
import 'package:weather_app/model/weather_data_hourly.dart';
import 'package:weather_app/model/weather_data_daily.dart';
import 'package:weather_app/utils/api_url.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  Future<WeatherData> processData(double latitude, double longitude) async {
    // Fetch current weather
    var currentResponse = await http.get(Uri.parse(apiURL(latitude, longitude)));
    if (currentResponse.statusCode != 200) {
      throw Exception("Failed to fetch current weather data");
    }
    var currentJson = jsonDecode(currentResponse.body);

    // Fetch forecast data
    var forecastResponse = await http.get(Uri.parse(apiURL1(latitude, longitude)));
    if (forecastResponse.statusCode != 200) {
      throw Exception("Failed to fetch forecast weather data");
    }
    var forecastJson = jsonDecode(forecastResponse.body);

    // Parse the data
    return WeatherData(
      current: WeatherDataCurrent.fromJson(currentJson),
      hourly: WeatherDataHourly.fromJson(forecastJson),
      daily: WeatherDataDaily.fromJson(forecastJson),
    );
  }
}