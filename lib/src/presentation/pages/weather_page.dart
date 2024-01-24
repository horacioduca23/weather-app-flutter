import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/location_text_field.dart';

import '../../constants/strings.dart';
import '../../constants/assets.dart';
import '../controllers/location_permission_controller.dart';
import '../widgets/current_location_weather.dart';
import '../widgets/default_cities.dart';
import '../widgets/request_permission_button.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLocationPermissionGranted =
        ref.watch(locationPermissionControllerProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 40.0,
            right: 40.0,
            top: 75.0,
          ),
          child: Column(
            mainAxisAlignment: isLocationPermissionGranted != true
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.start,
            children: [
              const Text(
                Strings.appTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                  height: 0.02,
                  letterSpacing: 0.37,
                ),
              ),
              const LocationTextField(),
              const DefaultCities(),
              const SizedBox(
                height: 30.0,
              ),
              isLocationPermissionGranted == true
                  ? const CurrentLocationWeather()
                  : const RequestPermissionButton(),
            ],
          ),
        ),
      ),
    );
  }
}
