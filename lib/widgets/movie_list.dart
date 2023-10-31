import 'package:flutter/material.dart';
import 'package:movies_app_flutter/models/movie.dart';
import 'package:movies_app_flutter/screens/movie_detail.dart';
import 'package:movies_app_flutter/services/movie_service.dart';
import 'package:movies_app_flutter/utils/functions.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key, required this.endpoint});
  final String endpoint;

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  MovieService? _movieService;
  List<Movie>? _movies;

  initialize() async {
    _movies =
        (await _movieService?.getAll(widget.endpoint))?.data as List<Movie>;
    setState(() {
      _movies = _movies;
    });
  }

  @override
  void initState() {
    _movieService = MovieService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _movies?.length ?? 0,
        itemBuilder: (context, index) {
          return MovieItem(movie: _movies![index]);
        });
  }
}

class MovieItem extends StatefulWidget {
  const MovieItem({super.key, required this.movie});
  final Movie movie;

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    final image = Image.network(getUrl(widget.movie.posterPath));
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetail(
              movie: widget.movie,
            ),
          ),
        );
      },
      child: SizedBox(
        width: width / 3,
        child: Card(
          child: Column(
            children: [
              image,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.movie.title,
                  maxLines: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
