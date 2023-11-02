import 'package:flutter/material.dart';
import 'package:movies_app_flutter/repositories/favorite_movie_repository.dart';

class FavoriteMovieList extends StatefulWidget {
  const FavoriteMovieList({super.key});

  @override
  State<FavoriteMovieList> createState() => _FavoriteMovieListState();
}

class _FavoriteMovieListState extends State<FavoriteMovieList> {
  FavoriteMovieRepository? _favoriteMovieRepository;
  List? _favoriteMovies;

  initialize() async {
    _favoriteMovies = await _favoriteMovieRepository!.getAll();
    if (mounted) {
      setState(() {
        _favoriteMovies = _favoriteMovies;
      });
    }
  }

  @override
  void initState() {
    _favoriteMovieRepository = FavoriteMovieRepository();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: (_favoriteMovies == null) ? 0 : _favoriteMovies!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_favoriteMovies![index].toString()),
          );
        });
  }
}
