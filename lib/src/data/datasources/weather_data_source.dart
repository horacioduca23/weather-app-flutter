import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' show Client;

import 'i_weather_data_source.dart';
import '../dtos/weather_dto.dart';

class WeatherDataSource implements IWeatherDataSource {
  String apiKey = dotenv.env['API_KEY']!;
  String baseUrl = dotenv.env['BASE_URL']!;

  final Client client = Client();

  @override
  Future<WeatherDTO> fetchWeatherByCity(String cityName) async {
    WeatherDTO weatherDTO;

    final response = await client.get(
      Uri.parse(
        '$baseUrl?q=$cityName&appid=$apiKey&units=metric',
      ),
    );
    print('Http Status Code == "${response.statusCode}"');
    if (response.statusCode == 200) {
      weatherDTO = WeatherDTO.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception(
        'Error Fetching Data, Http Status Code == "${response.statusCode}"',
      );
    }

    return weatherDTO;
  }
}
