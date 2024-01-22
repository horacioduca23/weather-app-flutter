import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/strings.dart';
import '../../data/datasources/network_utility.dart';
import '../../data/dtos/google_autocomplete_dto.dart';
import '../controllers/selected_city_controller.dart';

import '../../domain/prediction.dart';

class LocationTextField extends ConsumerStatefulWidget {
  const LocationTextField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return LocationTextFieldState();
  }
}

class LocationTextFieldState extends ConsumerState<LocationTextField> {
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

    return Column(
      children: [
        Form(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              onFieldSubmitted: (query) {
                ref
                    .read(selectedCityControllerProvider.notifier)
                    .setCityName(query);

                print(ref.read(selectedCityControllerProvider.notifier));
              },
              onChanged: (value) {
                placeAutocomplete(value);
              },
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                hintText: 'Search your location',
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Icon(
                    Icons.location_pin,
                  ),
                ),
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: placePredictions.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(placePredictions[index].description),
          ),
        ),
      ],
    );
  }
}
