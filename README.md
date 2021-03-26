# Movie App with Riverpod

A simple demonstration of using `flutter_riverpod` to fetch data from api and render on UI.


Hey Folks! Today we are going learn about how we can fetch API in the flutter app using **Riverpod** instead of the Future.

        #Riverpod;
        #“Also a provider but a different one”

What we do here is Create a Provider and Consume the Provider. In this project we are going to see how to make REST API calls.

Lets Start!!

We will be using the `https://api.themoviedb.org/3` to fetch the list of movies.

## Step 1 :  Install Packages

Place the below dependencies in your `pubspec.yaml' file and run
```
  dio: ^3.0.10
  flutter_riverpod: any
  eva_icons_flutter: ^2.0.1
  cached_network_image:
  intl:
```

The most important ones are the `flutter_riverpod` for state management and `dio` for making rest api calls. The others are for flavoring the app and can be ignored if not required. After this run `pub get` command.

## Step 2 : Add Model Classes

Create the 1st model class file as `movie.dart`

```
class Movie {
  final int id;
  final num popularity;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;
  final String releaseDate;
  final double votes;
  final num voteCount;

  Movie(this.id, this.popularity, this.title, this.backPoster, this.poster,
      this.overview, this.releaseDate,this.votes,this.voteCount);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"],
        title = json["title"],
        backPoster = json["backdrop_path"],
        poster = json["poster_path"],
        overview = json["overview"],
        releaseDate = json["release_date"],
        votes = json["vote_average"].toDouble(),
        voteCount = json["vote_count"];

}
```

Create another model class which holds this model class as `movie_response.dart`

```
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
```

## Step 3 : Fetching Movies from API

`remote_api.dart` is responsible for making rest api calls.

```
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
```

## Step 4 : State Manager

`state_manager.dart` will help us to manage the state of our app.

```
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/network/remote_api.dart';

final movieResponseFuture = FutureProvider<MovieResponse>((ref) async {
  return getMovies();
});
```

## Step 5 : Create UI of our app

`movie_list.dart` holds the UI of our app.

```
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
```

## Step 6 : Creating a Provider scope

Wrap your `main.dart` file with ProvideScope.

```
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/pages/movies_list.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Color(0xFF1D1D27),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MoviesListPage(),
    );
  }
}
```

**Note** : Apart from this there is another file `movie_details.dart` which is used to display the movie. Other classes like `app_theme.dart` and `strings.dart` are to add some flavours to our app. I think they are self explanatory!

That's it folks! We're done with all the coding. Just go ahead and run your app!

Fantastic!! You have jusr learned how to work with APIs using `Riverpod`.

## Important:

This repository is only for providing information on `flutter_riverpod`. Please do not misuse it.

## Author:

* [Amit Mishra](https://github.com/amitmishra7)
