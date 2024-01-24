import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../constants/assets.dart';
import '../controllers/selected_city_controller.dart';
import '../controllers/weather_by_city_controller.dart';

String getWeatherAnimation(String? mainCondition) {
  if (mainCondition == null) {
    return Assets.lottieSunny;
  }

  switch (mainCondition.toLowerCase()) {
    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
      return Assets.lottieCloud;
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return Assets.lottieRain;
    case 'thunderstorm':
      return Assets.lottieThunder;
    case 'clear':
      return Assets.lottieSunny;

    default:
      return Assets.lottieSunny;
  }
}

class WeatherCurrentPage extends ConsumerWidget {
  const WeatherCurrentPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final selectedCity = ref.read(selectedCityControllerProvider);
    final weatherData = ref.watch(weatherByCityControllerProvider);

    return weatherData.when(
      data: (weather) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: (weather?.id ?? 600) < 600
                    ? const AssetImage(Assets.cloudy)
                    : now.hour >= 15
                        ? const AssetImage(Assets.night)
                        : const AssetImage(Assets.sunny),
                fit: BoxFit.cover,
              ),
            ),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedCity,
                  style: TextStyle(
                    color: now.hour >= 15 ? Colors.white : Colors.black,
                    fontSize: 50,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                    height: 0.02,
                    letterSpacing: 0.37,
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Lottie.asset(
                  getWeatherAnimation(weather?.mainCondition),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  '${weather?.temperature.ceilToDouble()}°C',
                  style: TextStyle(
                    color: now.hour >= 15 ? Colors.white : Colors.black,
                    fontSize: 100,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                    height: 0.02,
                    letterSpacing: 0.37,
                  ),
                ),
                const SizedBox(
                  height: 100.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'H:${weather?.maxTemperature.ceil().toString()}°C / L:${weather?.minTemperature.ceil().toString()}°C',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w800,
                        height: 0.11,
                        letterSpacing: -0.08,
                      ),
                    ),
                    Text(
                      'W:${weather?.windSpeed.toString()} km/h',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w800,
                        height: 0.11,
                        letterSpacing: -0.08,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stack) => Text(
        error.toString(),
      ),
      loading: () {
        return const Scaffold(
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.background),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
