import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movies.model.dart';

class MovieController {
  final String apiKey = '4b3dd54';

  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await http.get(Uri.parse('http://www.omdbapi.com/?s=$query&apikey=$apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if 'Search' exists and is a list
        if (data['Search'] != null && data['Search'] is List) {
          return (data['Search'] as List).map((movie) => Movie.fromJson(movie)).toList();
        } else {
          // If no results found, return an empty list
          return [];
        }
      } else {
        throw Exception('Failed to load movies. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Print any error that occurs
      print("Error occurred: $e");
      throw Exception('Error occurred while fetching movies');
    }
  }
}
