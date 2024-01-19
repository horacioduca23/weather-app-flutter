import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;

class NetworkUtility {
  final Client client = Client();

  Future<String?> fetchUrl(Uri uri, {Map<String, String>? headers}) async {
    try {
      final response = await client.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
    return null;
  }
}
