class WeatherModel {
  final double temp;
  final int humidity;
  final double windSpeed;
  final String cityName;
  final String condition;

  WeatherModel({
    required this.temp,
    required this.humidity,
    required this.windSpeed,
    required this.cityName,
    required this.condition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp: json['main']['temp'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      cityName: json['name'],
      condition: json['weather'][0]['main'],
    );
  }
}
