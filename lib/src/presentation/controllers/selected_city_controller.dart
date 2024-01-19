import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_city_controller.g.dart';

@Riverpod(keepAlive: true)
class SelectedCityController extends _$SelectedCityController {
  String? _selectedCity;

  @override
  String build() {
    return _selectedCity ?? '';
  }

  void setCityName(String cityName) {
    _selectedCity = state = cityName;
  }
}
