import 'package:weather_app_flutter/src/data/dtos/weather_dto.dart';
import 'package:weather_app_flutter/src/domain/weather.dart';

extension WeatherMapper on WeatherDTO {
  Weather toModel() {
    return Weather(
      cityName: cityName,
      id: id,
      mainCondition: mainCondition,
      maxTemperature: maxTemperature,
      minTemperature: minTemperature,
      temperature: temperature,
      windSpeed: windSpeed,
    );
  }
}
