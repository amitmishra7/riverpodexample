import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/style/app_theme.dart' as Style;
import 'package:movie_app/style/strings.dart';

class MoviesDetailsScreen extends StatelessWidget {
  final Movie movie ;
  final newFormat = DateFormat("dd MMM yyyy");

  MoviesDetailsScreen({
    @required this.movie,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        title: Text(movie.title),

      ),
      // drawer: Drawer(),
      body:  Container(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
              child: Container(
                  height: 300.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: new BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.0)),
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: CachedNetworkImageProvider(
                            "https://image.tmdb.org/t/p/w500" +
                                movie.poster)),
                  )),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0,top: 8.0,right: 24.0,bottom: 8.0),
              child: Container(
                child: Text(
                  "${Strings.releaseDate} ${ parseDate(movie.releaseDate)}",
                  maxLines: 2,
                  style: TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0,top: 8.0,right: 24.0,bottom: 8.0),
              child: Container(
                child: Text(
                  "${Strings.overview}${movie.overview}",
                  style: TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0,top: 8.0,right: 24.0,bottom: 8.0),
              child: Container(
                child: Text(
                  "${Strings.popularity}${movie.popularity}",
                  maxLines: 2,
                  style: TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0,top: 8.0,right: 24.0,bottom: 8.0),
              child: Container(
                child: Text(
                  "${Strings.voteAvg}${movie.votes}/10",
                  maxLines: 2,
                  style: TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 8.0,top: 8.0,right: 24.0,bottom: 8.0),
              child: Container(
                child: Text(
                  "${Strings.voteCount}${movie.voteCount}",
                  maxLines: 2,
                  style: TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
              ),
            ),

          ],
        ),
      )
    );
  }

  String parseDate(String releaseDate) {
    try {
      return newFormat.format(DateFormat("yyyy-MM-dd").parse(releaseDate));
    } catch (err) {
      return "";
    }
  }
}
