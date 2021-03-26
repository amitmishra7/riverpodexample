import 'movie.dart';

class MovieResponse {
  final List<Movie> movies;
  final String error;
  final int totalPages;

  MovieResponse(this.movies, this.error, this.totalPages);

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movies = (json["results"] as List)
            .map((i) => new Movie.fromJson(i))
            .toList(),
        error = "",
        totalPages = json["total_pages"];

  MovieResponse.withError(String errorValue)
      : movies = List(),
        error = errorValue,
        totalPages = 0;
}
