// instance for getting the api response
class WeatherDataCurrent {
  final Main main;
  final List<Weather> weather;
  final Wind wind;
  final Clouds clouds;
  final Sys sys;
  final String name; // City name
  final int visibility;
  final String timezone;

  WeatherDataCurrent({
    required this.main,
    required this.weather,
    required this.wind,
    required this.clouds,
    required this.sys,
    required this.name,
    required this.visibility,
    required this.timezone,
  });

  factory WeatherDataCurrent.fromJson(Map<String, dynamic> json) {
    return WeatherDataCurrent(
      main: Main.fromJson(json['main']),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      sys: Sys.fromJson(json['sys']),
      name: json['name'] ?? "Unknown", // Fallback to "Unknown" if name is null
      visibility: json['visibility'] ?? 0, // Default to 0 if visibility is null
      timezone: json['timezone']?.toString() ?? "0", // Default to "0" if timezone is null
    );
  }
}

class Main {
  final int temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: (json['temp'] as num).toInt(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      tempMin: (json['temp_min'] as num).toDouble(),
      tempMax: (json['temp_max'] as num).toDouble(),
      pressure: json['pressure'] as int,
      humidity: json['humidity'] as int,
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

class Wind {
  final double speed;
  final int deg;
  final double? gust; // Allow gust to be nullable

  Wind({
    required this.speed,
    required this.deg,
    this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: (json['speed'] as num).toDouble(),
      deg: json['deg'] as int,
      gust: json['gust'] != null ? (json['gust'] as num).toDouble() : null, // Handle null safely
    );
  }
}

class Clouds {
  final int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'] as int,
    );
  }
}

class Sys {
  final String country;
  final int sunrise;
  final int sunset;

  Sys({
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      country: json['country'] as String,
      sunrise: json['sunrise'] as int,
      sunset: json['sunset'] as int,
    );
  }
}