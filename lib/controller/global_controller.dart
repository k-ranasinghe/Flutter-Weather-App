import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/api/fetch_weather.dart';
import 'package:weather_app/model/weather_data.dart';

class GlobalController extends GetxController {

  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  final weatherData = WeatherData().obs;
  WeatherData getWeatherData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;
    
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    
    if (!isServiceEnabled) {
      return Future.error("Location services are disabled.");
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are denied Forever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      _isLoading.value = false;
      return FetchWeatherAPI()
        .processData(_latitude.value, _longitude.value)
        .then((value) {
          weatherData.value = value;
          _isLoading.value = false;
      });
    });
  }

  RxInt getIndex() {
    return _currentIndex;
  }
}