import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '220f170de3bed49f367573da5c905f33';
  final String _language = 'es-ES';
  final String _page = '1';

  List<Movie> onDisplayMovies = [];
  List<Movie> onOnPopular = [];
  List<Movie> topRatedMovies = [];
  List<Movie> upcomingMovies = [];

  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    //print('Movies Provider inicialitzat.');
    getOnDisplayMovies();
    getOnPopular();
    getOnTopRatedMovies();
    getUpcomingMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    final result = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

    onDisplayMovies = nowPlayingResponse.results; //lista de peliculas

    notifyListeners();
  }

  getOnPopular() async {
    var url = Uri.https(
      _baseUrl,
      '3/movie/popular',
      {'api_key': _apiKey, 'language': _language, 'page': _page},
    );

    final result = await http.get(url);

    final popResponse = PopularResponse.fromJson(result.body);

    onOnPopular = popResponse.results;

    notifyListeners();
  }

  getOnTopRatedMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/top_rated', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page,
    });

    final result = await http.get(url);

    final topRatedResponse = TopRatedResponse.fromJson(result.body);

    topRatedMovies = topRatedResponse.results;

    notifyListeners();
  }

  getUpcomingMovies() async {
    var url = Uri.https(
      _baseUrl,
      '3/movie/upcoming',
      {
        'api_key': _apiKey,
        'language': _language,
        'page': _page,
      },
    );

    final result = await http.get(url);

    final upcomingResponse = UpcomingFilmsResponse.fromJson(result.body);

    upcomingMovies = upcomingResponse.results;

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int idMovie) async {
    var url = Uri.https(_baseUrl, '3/movie/$idMovie/credits',
        {'api_key': _apiKey, 'language': _language});

    final result = await http.get(url);

    final creditsResponse = CreditsResponse.fromJson(result.body);

    casting[idMovie] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
