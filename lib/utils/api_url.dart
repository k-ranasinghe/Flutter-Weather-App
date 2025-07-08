import 'package:weather_app/utils/api_key.dart';

String apiURL(var latitude, var longitude) {
  String url;
  url = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
  return url;
}

String apiURL1(var latitude, var longitude) {
  String url;
  url = 'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
  return url;
}