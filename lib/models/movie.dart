class Movie {
  final int id;
  final String title;
  final double voteAverage;
  final String overview;
  final String posterPath;

  const Movie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.voteAverage,
      required this.posterPath});

  Movie.fromJson(Map<String, dynamic> json):
    id = json['id'],
    title = json['title'],
    overview = json['overview'],
    voteAverage = json['vote_average'],
    posterPath = json['poster_path'];
 
}
