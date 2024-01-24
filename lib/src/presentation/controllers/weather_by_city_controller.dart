import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'selected_city_controller.dart';
import '../../domain/weather.dart';
import '../providers.dart';

part 'weather_by_city_controller.g.dart';

@riverpod
class WeatherByCityController extends _$WeatherByCityController {
  @override
  Future<Weather?> build() async {
    final weather = await fetchWeatherByCity();

    return weather;
  }

  Future<Weather?> fetchWeatherByCity() async {
    final cityName = ref.read(selectedCityControllerProvider);
    Weather? weather;

    try {
      final weatherRepository = ref.read(weatherRepositoryProvider);

      final result = await AsyncValue.guard(
        () => weatherRepository.fetchWeatherByCity(cityName),
      );

      result.whenData(
        (value) => weather = value,
      );
    } on Exception catch (ex, stack) {
      state = AsyncValue.error(ex, stack);
    }

    return weather;
  }

  Future<String?> fetchCityNameByCurrent(
    double latitude,
    double longitude,
  ) async {
    String? cityName;

    try {
      final weatherRepository = ref.read(weatherRepositoryProvider);

      final result = await AsyncValue.guard(
        () => weatherRepository.fetchCityNameByCurrent(latitude, longitude),
      );

      result.whenData((value) {
        if (value != null) {
          return cityName = value;
        }
      });
    } on Exception catch (ex, stack) {
      state = AsyncValue.error(ex, stack);
    }

    return cityName ?? '';
  }
}
