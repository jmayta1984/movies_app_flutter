import 'package:flutter/material.dart';
import 'package:movies_app_flutter/models/movie.dart';
import 'package:movies_app_flutter/repositories/favorite_movie_repository.dart';
import 'package:movies_app_flutter/utils/functions.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({super.key, required this.movie});
  final Movie movie;

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  bool _favorite = false;

  initialize() async {
    _favorite = await FavoriteMovieRepository().isFavorite(widget.movie.id);
    if (mounted) {
      setState(() {
        _favorite = _favorite;
      });
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final icon =
        Icon(Icons.favorite, color: _favorite ? Colors.red : Colors.grey);

    final image = Image.network(getUrl(widget.movie.posterPath));
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: image,
                title: Text(widget.movie.title),
              ),
            )
          ];
        },
        body: Column(
          children: [
            IconButton(
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      _favorite = !_favorite;
                    });
                  }

                  _favorite
                      ? FavoriteMovieRepository().insert(widget.movie.id)
                      : FavoriteMovieRepository().delete(widget.movie.id);
                },
                icon: icon),
            Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.movie.overview),
            )),
          ],
        ),
      ),
    );
  }
}
