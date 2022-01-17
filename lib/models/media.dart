import 'dart:convert';

import 'package:http/http.dart' as http;

enum MediaType {
  movie,
  tv,
}

class Media {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final DateTime releaseDate;
  final double rating;
  final List genreIds;
  final MediaType mediaType;
  bool saved;

  Media({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.rating,
    required this.genreIds,
    required this.mediaType,
    this.saved = false,
  });

  Future<Map<String, dynamic>> fetchMediaDetails() async {
    final url = Uri.parse(
        "https://api.themoviedb.org/3/movie/$id?api_key=f3bd2972ff18fb5a27642376d95dc972&language=en-US");
    final args = await http.get(url);
    return json.decode(args.body);
  }
}
