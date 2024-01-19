class WeatherDTO {
  const WeatherDTO({
    required this.cityName,
    required this.id,
    required this.mainCondition,
    required this.maxTemperature,
    required this.minTemperature,
    required this.temperature,
    required this.windSpeed,
  });

  factory WeatherDTO.fromJson(Map<String, dynamic> json) {
    return WeatherDTO(
      cityName: json['name'],
      id: json['weather'][0]['id'].toInt() ?? 600,
      mainCondition: json['weather'][0]['main'],
      maxTemperature: json['main']['temp_max'].toDouble(),
      minTemperature: json['main']['temp_min'].toDouble(),
      temperature: json['main']['temp'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }

  final String cityName;
  final int id;
  final String mainCondition;
  final double maxTemperature;
  final double minTemperature;
  final double temperature;
  final double windSpeed;
}
