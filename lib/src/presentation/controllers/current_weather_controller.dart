import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/weather.dart';
import '../providers.dart';

part 'current_weather_controller.g.dart';

@riverpod
class CurrentWeatherController extends _$CurrentWeatherController {
  @override
  Future<Weather?> build() async {
    final weather = await fetchWeatherByCurrent();

    return weather;
  }

  Future<Weather?> fetchWeatherByCurrent() async {
    Weather? weather;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    String? cityName = placemarks[0].locality ?? '';

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
}
