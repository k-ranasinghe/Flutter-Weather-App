class WeatherDataHourly {
  List<Hourly> hourly;

  WeatherDataHourly({required this.hourly});

  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) {
    return WeatherDataHourly(
      hourly: List<Hourly>.from(
        (json['list'] as List).map((e) => Hourly.fromJson(e)),
      ),
    );
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'] as int,
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  };
}

class Hourly {
  int? dt; // Timestamp
  int? temp;
  double? feelsLike;
  int? pressure;
  int? humidity;
  double? windSpeed;
  int? windDeg;
  double? rainVolume; // Rain volume in last 3 hours
  String? dtTxt; // Date-time text
  List<Weather>? weather;

  Hourly({
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.windSpeed,
    this.windDeg,
    this.rainVolume,
    this.dtTxt,
    this.weather,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
      dt: json['dt'] as int?,
      temp: (json['main']['temp'] as num?)?.toInt(),
      feelsLike: (json['main']['feels_like'] as num?)?.toDouble(),
      pressure: json['main']['pressure'] as int?,
      humidity: json['main']['humidity'] as int?,
      windSpeed: (json['wind']['speed'] as num?)?.toDouble(),
      windDeg: json['wind']['deg'] as int?,
      rainVolume: (json['rain']?['3h'] as num?)?.toDouble(),
      dtTxt: json['dt_txt'] as String?,
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'temp': temp,
      'feels_like': feelsLike,
      'pressure': pressure,
      'humidity': humidity,
      'wind_speed': windSpeed,
      'wind_deg': windDeg,
      'rain_volume': rainVolume,
      'dt_txt': dtTxt,
      'weather': weather?.map((e) => e.toJson()).toList(),
    };
  }
}
