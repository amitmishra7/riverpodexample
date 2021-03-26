import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/pages/movie_details.dart';
import 'package:movie_app/style/app_theme.dart' as Style;
import 'package:movie_app/style/strings.dart';

class MovieItem extends StatelessWidget {
  final Movie movie ;
  final newFormat = DateFormat("dd MMM yyyy");

  MovieItem({
    @required this.movie,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 10.0, bottom: 10.0, right: 5.0, left: 5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MoviesDetailsScreen(movie: movie),
            ),
          );
        },
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              movie.poster == null
                  ? Container(
                height: 80.0,
                width: 80.0,
                decoration: new BoxDecoration(
                  color: Style.Colors.secondColor,
                  borderRadius:
                  BorderRadius.all(Radius.circular(10.0)),
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      EvaIcons.filmOutline,
                      color: Colors.white,
                      size: 60.0,
                    )
                  ],
                ),
              )
                  : Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: new BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.0)),
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: CachedNetworkImageProvider(
                            "https://image.tmdb.org/t/p/w92" +
                                movie.poster)),
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        movie.releaseDate != null
                            ? "Released on " +
                            parseDate(movie.releaseDate)
                            : "",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "${movie.votes.toString()}${Strings.voteAvgList}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "${movie.voteCount.toString()}${Strings.voters}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Divider(
            color: Colors.white,
          )
        ]),
      ),
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