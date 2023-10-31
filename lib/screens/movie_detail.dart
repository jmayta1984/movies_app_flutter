import 'package:flutter/material.dart';
import 'package:movies_app_flutter/models/movie.dart';
import 'package:movies_app_flutter/utils/functions.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({super.key, required this.movie});
  final Movie movie;

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    final image = Image.network(getUrl(widget.movie.posterPath));
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(background: image, title: Text(widget.movie.title),),
            )
          ];
        }, body: Text(widget.movie.overview),
      ),
    );
  }
}
