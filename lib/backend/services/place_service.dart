import 'dart:convert';
import 'package:Realify/backend/models/places.dart';
import 'package:Realify/con.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:http/http.dart';

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider();

  static final String androidKey = kGoogleApiKey;
  // static final String iosKey = 'YOUR_API_KEY_HERE';
  final apiKey = androidKey;

  Future<List<Suggestion>> fetchSuggestions(String input, BuildContext context) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=$apiKey&language=en&input=$input';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions'].map<Suggestion>((p) => Suggestion(p['place_id'], p['description'])).toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&language=en&key=$apiKey';
    final response = await client.get(Uri.parse(request));
    print(response);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components = result['result']['address_components'] as List<dynamic>;
        final coordinates = result['result']['geometry']['location'] as Map<String, dynamic>;
        var formatted_address = result['result']['formatted_address'] as String;
        // build result
        final place = Place();
        components.forEach((c) {
          final List type = c['types'];
          if (type.contains('route')) {
            place.route = c['long_name'];
          }
          if (type.contains('locality')) {
            place.locality = c['long_name'];
          }
          if (type.contains('administrative_area_level_1')) {
            place.administrativeAreaLevel1 = c['long_name'];
          }
          if (type.contains('country')) {
            place.country = c['long_name'];
          }
        });
        coordinates.forEach((key, value) {
          if (key == 'lat') {
              place.lat = value;
          }else if (key == 'lng') {
             place.lng = value;
          }
        });
        place.formattedAddress = formatted_address;
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
