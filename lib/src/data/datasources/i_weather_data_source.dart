import '../dtos/weather_dto.dart';

abstract class IWeatherDataSource {
  Future<String?> fetchCityNameByCurrent(
    double latitude,
    double longitude,
  );
  Future<WeatherDTO> fetchWeatherByCity(String cityName);
}
