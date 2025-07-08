import 'package:intl/intl.dart';

class WeatherDataDaily {
  List<Daily> daily;

  WeatherDataDaily({required this.daily});

  factory WeatherDataDaily.fromJson(Map<String, dynamic> json) {
    // Group data by date
    Map<String, List<dynamic>> groupedData = {};
    for (var entry in json['list']) {
      String date = DateFormat('yyyy-MM-dd').format(DateTime.parse(entry['dt_txt']));
      if (!groupedData.containsKey(date)) {
        groupedData[date] = [];
      }
      groupedData[date]!.add(entry);
    }

    // Process each group into daily summaries
    List<Daily> dailyList = groupedData.entries.map((entry) {
      var date = entry.key;
      var data = entry.value;

      int? minTemp = data.map((e) => (e['main']['temp_min'] as num)).reduce((a, b) => a < b ? a : b).round();
      int? maxTemp = data.map((e) => (e['main']['temp_max'] as num)).reduce((a, b) => a > b ? a : b).round();

      // Pick the most frequent weather condition
      Map<String, int> weatherFrequency = {};
      data.forEach((item) {
        String weatherMain = item['weather'][0]['main'];
        weatherFrequency[weatherMain] = (weatherFrequency[weatherMain] ?? 0) + 1;
      });
      String mostFrequentWeather = weatherFrequency.entries.reduce((a, b) => a.value > b.value ? a : b).key;
      var representativeWeather = data.firstWhere((e) => e['weather'][0]['main'] == mostFrequentWeather)['weather'][0];

      return Daily(
        dt: DateTime.parse(date).millisecondsSinceEpoch ~/ 1000,
        temp: Temp(
          min: minTemp.round(),
          max: maxTemp.round(),
        ),
        weather: [
          Weather.fromJson(representativeWeather),
        ],
      );
    }).toList();

    return WeatherDataDaily(daily: dailyList);
  }
}

class Daily {
  int? dt;
  Temp? temp;
  List<Weather>? weather;

  Daily({
    this.dt,
    this.temp,
    this.weather,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
    dt: json['dt'] as int?,
    temp: json['temp'] == null
        ? null
        : Temp.fromJson(json['temp'] as Map<String, dynamic>),
    weather: (json['weather'] as List<dynamic>?)
        ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'temp': temp?.toJson(),
    'weather': weather?.map((e) => e.toJson()).toList(),
  };
}

class Temp {
  int? min;
  int? max;

  Temp({this.min, this.max});

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
    min: (json['min'] as num?)?.round(),
    max: (json['max'] as num?)?.round(),
  );

  Map<String, dynamic> toJson() => {
    'min': min,
    'max': max,
  };
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json['id'] as int?,
    main: json['main'] as String?,
    description: json['description'] as String?,
    icon: json['icon'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  };
}
