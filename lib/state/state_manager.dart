import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/network/remote_api.dart';

final movieResponseFuture = FutureProvider<MovieResponse>((ref) async {
  return getMovies();
});