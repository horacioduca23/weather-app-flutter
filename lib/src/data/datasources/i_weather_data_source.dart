import '../dtos/weather_dto.dart';

abstract class IWeatherDataSource {
  Future<WeatherDTO> fetchWeatherByCity(String cityName);
}
