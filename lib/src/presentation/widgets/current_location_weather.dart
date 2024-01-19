import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../controllers/current_weather_controller.dart';
import '../pages/weather_detail_page.dart';

class CurrentLocationWeather extends ConsumerWidget {
  const CurrentLocationWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherData = ref.watch(currentWeatherControllerProvider);

    return weatherData.when(
      data: (weather) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weather?.cityName ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 46,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
                height: 0.02,
                letterSpacing: 0.37,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Lottie.asset(
              getWeatherAnimation(weather?.mainCondition),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              '${weather?.temperature.ceilToDouble()}°C',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 70,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
                height: 0.02,
                letterSpacing: 0.37,
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'H:${weather?.maxTemperature.ceil().toString()}°C / L:${weather?.minTemperature.ceil().toString()}°C',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
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
                    fontSize: 18.0,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w800,
                    height: 0.11,
                    letterSpacing: -0.08,
                  ),
                ),
              ],
            ),
          ],
        );
      },
      error: (error, stack) => Text(
        error.toString(),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
