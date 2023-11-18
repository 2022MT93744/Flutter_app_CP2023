import 'dart:convert';
import 'package:http/http.dart' as http;

class ImdbApi {
  static const String _apiKey = '99743d2ff7msh047f6d734a28baap1f2348jsn00434be0c6c6';
  static const String _apiHost = 'movie-database-alternative.p.rapidapi.com';

  Future<Map<String, dynamic>> searchMovies(String query) async {
    final response = await http.get(
      Uri.https(_apiHost, '/movie/' + Uri.encodeComponent(query)),
      headers: {
        'X-RapidAPI-Key': _apiKey,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
