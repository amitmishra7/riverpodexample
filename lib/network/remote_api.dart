

import 'package:dio/dio.dart';
import 'package:movie_app/model/movie_response.dart';

String apiKey = "6753d9119b9627493ae129f3c3c99151";
String mainUrl = "https://api.themoviedb.org/3";

final Dio _dio = Dio();

var moviesUrl = 'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=superman';

Future<MovieResponse> getMovies() async {
  var params = {'api_key': apiKey, 'language': 'en-US', 'page': 1};

  try {
    Response response = await _dio.get(moviesUrl,
        queryParameters: params
    );
    return MovieResponse.fromJson(response.data);
  } catch (error, stacktrace) {
    print("Exception occured: $error stackTrace: $stacktrace");
    return MovieResponse.withError("$error");
  }
}