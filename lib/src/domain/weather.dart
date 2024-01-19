class Weather {
  const Weather({
    required this.cityName,
    required this.id,
    required this.mainCondition,
    required this.maxTemperature,
    required this.minTemperature,
    required this.temperature,
    required this.windSpeed,
  });

  final String cityName;
  final int id;
  final String mainCondition;
  final double maxTemperature;
  final double minTemperature;
  final double temperature;
  final double windSpeed;
}
