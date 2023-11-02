import 'package:flutter/material.dart';
import 'package:movies_app_flutter/widgets/movie_list.dart';

class Movies extends StatelessWidget {
  const Movies({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height / 3,
              child: const MovieList(endpoint: 'popular'),
            ),
            SizedBox(
              height: height / 3,
              child: const MovieList(endpoint: 'upcoming'),
            ),
            SizedBox(
              height: height / 3,
              child: const MovieList(endpoint: 'top_rated'),
            )
          ],
        ),
      ),
    );
  }
}
