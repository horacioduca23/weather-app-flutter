import '../dtos/mappers/weather_mapper.dart';
import '../../domain/weather.dart';
import '../datasources/i_weather_data_source.dart';

class WeatherRepository {
  WeatherRepository({
    required IWeatherDataSource weatherDataSource,
  }) : _weatherDataSource = weatherDataSource;

  final IWeatherDataSource _weatherDataSource;

  Future<Weather> fetchWeatherByCity(String cityName) async {
    Weather weather;

    final weatherDTO = await _weatherDataSource.fetchWeatherByCity(cityName);

    weather = weatherDTO.toModel();

    return weather;
  }
}
