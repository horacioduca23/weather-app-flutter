class Prediction {
  Prediction({
    required this.description,
    required this.mainText,
    required this.placeId,
    this.secondaryText,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      description: json['description'] as String,
      mainText: json['structured_formatting']['main_text'] as String,
      placeId: json['place_id'] as String,
      secondaryText: json['structured_formatting']['secondary_text'] as String?,
    );
  }

  final String description;
  final String mainText;
  final String placeId;
  final String? secondaryText;
}
