import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' show Client;

import '../../constants/strings.dart';
import 'i_weather_data_source.dart';
import '../dtos/weather_dto.dart';

class WeatherDataSource implements IWeatherDataSource {
  String apiKey = dotenv.env['API_KEY']!;
  final Client client = Client();

  @override
  Future<WeatherDTO> fetchWeatherByCity(String cityName) async {
    WeatherDTO weatherDTO;

    final response = await client.get(
      Uri.parse(
        '${Strings.baseUrl}?q=$cityName&appid=$apiKey&units=metric',
      ),
    );

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
