import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';

import '../controllers/weather_by_city_controller.dart';
import '../../constants/strings.dart';
import '../../data/datasources/network_utility.dart';
import '../../data/dtos/google_autocomplete_dto.dart';
import '../../domain/prediction.dart';
import '../../routes/app_routes.dart';
import '../controllers/selected_city_controller.dart';

class LocationTextField extends ConsumerStatefulWidget {
  const LocationTextField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return LocationTextFieldState();
  }
}

class LocationTextFieldState extends ConsumerState<LocationTextField> {
  final TextEditingController _controller = TextEditingController();
  List<Prediction> placePredictions = [];

  @override
  Widget build(BuildContext context) {
    void placeAutocomplete(String query) async {
      String apiKey = dotenv.env['GOOGLE_API_KEY']!;

      final Uri uri = Uri.https(
        Strings.googleMapsApi,
        Strings.googlePlacesAutocompleteUrl,
        {
          'input': query,
          'types': '(cities)',
          'key': apiKey,
        },
      );
      String? response = await NetworkUtility().fetchUrl(uri);

      if (response != null) {
        GoogleAutocompleteDTO result =
            GoogleAutocompleteDTO.parseAutocompleteResult(response);
        if (result.predictions != null) {
          setState(
            () {
              placePredictions = result.predictions!;
            },
          );
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: _controller,
            onChanged: (value) {
              placeAutocomplete(value);
            },
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: Strings.searchYourLocation,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Icon(
                  Icons.location_pin,
                ),
              ),
              prefixIconColor: Colors.white,
              suffixIcon: IconButton(
                onPressed: () {
                  _controller.text = '';
                  placeAutocomplete("");
                },
                icon: const Icon(Icons.close),
              ),
              suffixIconColor: Colors.white,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: placePredictions.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(placePredictions[index].description),
              onTap: () async {
                List<Location> locations = await locationFromAddress(
                  placePredictions[index].description,
                );

                final latitude = locations.last.latitude;
                final longitude = locations.last.longitude;

                final cityName = await ref
                        .read(weatherByCityControllerProvider.notifier)
                        .fetchCityNameByCurrent(latitude, longitude) ??
                    '';

                ref
                    .read(selectedCityControllerProvider.notifier)
                    .setCityName(cityName);

                // ignore: use_build_context_synchronously
                context.go('/${AppRoutes.current.path}');
              },
            ),
          ),
        ],
      ),
    );
  }
}
