import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
  final _pageSize = 20;

  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _movieService = MovieService();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future _fetchPage(int pageKey) async {
    try {
      final movies = (await _movieService!.getAll(widget.endpoint, pageKey))
          .data as List<Movie>;
      final isLastPage = movies.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(movies);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(movies, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Movie>(
        scrollDirection: Axis.horizontal,
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Movie>(
            itemBuilder: (context, item, index) {
          return MovieItem(movie: item);
        }));
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
