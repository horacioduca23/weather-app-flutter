import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/repositories/weather_repository.dart';
import '../data/datasources/i_weather_data_source.dart';
import '../data/datasources/weather_data_source.dart';

part 'providers.g.dart';

@riverpod
IWeatherDataSource weatherDataSource(
  WeatherDataSourceRef ref,
) {
  return WeatherDataSource();
}

@riverpod
WeatherRepository weatherRepository(
  WeatherRepositoryRef ref,
) {
  final weatherDataSource = ref.watch(weatherDataSourceProvider);

  return WeatherRepository(weatherDataSource: weatherDataSource);
}
