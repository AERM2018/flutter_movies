import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movies/models/models.dart';
import 'package:movies/models/top_rated_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = "07222469943fedf87b67347118644d3f";
  final String _baseUrl = "api.themoviedb.org";
  final String _language = "en-US";

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;
  int _topRated = 0;
  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
    getTopRatedMovies();
  }
  getPopularMovies() async {
    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  getTopRatedMovies() async {
    _topRated++;

    final jsonData = await _getJsonData('3/movie/top_rated', _topRated);
    final topRatedRespone = TopRatedResponse.fromJson(jsonData);

    topRatedMovies = [...topRatedMovies, ...topRatedRespone.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  getOnDisplayMovies() async {
    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }
}
