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
