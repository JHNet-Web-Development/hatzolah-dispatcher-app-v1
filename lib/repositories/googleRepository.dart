import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

// For storing our result
class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class GoogleRepository {
  final client = Client();

  GoogleRepository(this.sessionToken);

  final sessionToken;

  static const String androidKey = 'AIzaSyCeJqk0cSJ0ow7i1six5bZbf1hHzWINMR0';
  static const String iosKey = 'AIzaSyCeJqk0cSJ0ow7i1six5bZbf1hHzWINMR0';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    var request = Uri(
        scheme: 'https',
        host: 'maps.googleapis.com',
        path: '/maps/api/place/autocomplete/json?',
        queryParameters: {'input': input, 'address&language': lang, 'components': 'country', 'ch&key': apiKey, 'sessiontoken': sessionToken});
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}