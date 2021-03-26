import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/state/state_manager.dart';
import 'package:movie_app/style/app_theme.dart' as Style;
import 'package:movie_app/style/strings.dart';
import 'package:movie_app/widgets/movies_item.dart';

class MoviesListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    AsyncValue<MovieResponse> moviesResponse = watch(movieResponseFuture);
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        title: Text(Strings.appName),
      ),
      // drawer: Drawer(),
      body: moviesResponse.when(data: (value){
        var movies = value.movies;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            return MovieItem(movie: movies[index]);
          },
        );
      }, loading: ()=> Center(child: const CircularProgressIndicator()), error: (error,stack) => Center(child: Text('${error.toString()}'))),
    );
  }
}
