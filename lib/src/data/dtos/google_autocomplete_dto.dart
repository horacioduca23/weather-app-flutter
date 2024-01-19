import 'dart:convert';

import '../../domain/prediction.dart';

class GoogleAutocompleteDTO {
  const GoogleAutocompleteDTO({
    this.predictions,
    required this.status,
  });

  factory GoogleAutocompleteDTO.fromJson(Map<String, dynamic> json) {
    return GoogleAutocompleteDTO(
      status: json['status'] as String?,
      predictions: json['predictions'] != null
          ? json['predictions']
              .map<Prediction>((json) => Prediction.fromJson(json))
              .toList()
          : null,
    );
  }

  static GoogleAutocompleteDTO parseAutocompleteResult(String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();

    return GoogleAutocompleteDTO.fromJson(parsed);
  }

  final List<Prediction>? predictions;
  final String? status;
}
