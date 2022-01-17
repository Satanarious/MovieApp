import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../models/media.dart';
import 'package:http/http.dart' as http;

class AllMedia with ChangeNotifier {
  List<Media> _items = [];
  final List<Media> _favourites = [];

  Media getItemById(int id) {
    return _items.firstWhere((media) => media.id == id);
  }

  List<Media> getItems() {
    return [..._items];
  }

  List<Media> getMovies() {
    return _items.where((media) => media.mediaType == MediaType.movie).toList();
  }

  List<Media> getTv() {
    return _items.where((media) => media.mediaType == MediaType.tv).toList();
  }

  List<Media> getSaved() {
    return _items.where((media) => media.saved == true).toList();
  }

  Future<void> fetchAndConvertMedia() async {
    final url = Uri.parse(
        "https://api.themoviedb.org/3/trending/all/day?api_key=f3bd2972ff18fb5a27642376d95dc972");
    final list = await http.get(url);
    final List media = (json.decode(list.body) as Map)['results'];
    _items = [];
    for (var item in media) {
      if (item['media_type'] == "movie") {
        _items.add(Media(
            id: item['id'],
            title: item['title'],
            posterPath: item['poster_path'],
            backdropPath: item['backdrop_path'],
            overview: item['overview'],
            releaseDate: DateTime.parse(item['release_date']),
            rating: item['vote_average'],
            genreIds: item['genre_ids'],
            mediaType: MediaType.movie));
      } else {
        _items.add(Media(
            id: item['id'],
            title: item['name'],
            posterPath: item['poster_path'],
            backdropPath: item['backdrop_path'],
            overview: item['overview'],
            releaseDate: DateTime.parse(item['first_air_date']),
            rating: item['vote_average'],
            genreIds: item['genre_ids'],
            mediaType: MediaType.tv));
      }
    }

    notifyListeners();
  }

  void addFavourite(Media fav) {
    _favourites.add(fav);
    notifyListeners();
  }

  void removeFavourite(int id) {
    _favourites.removeWhere((media) => media.id == id);
    notifyListeners();
  }
}
