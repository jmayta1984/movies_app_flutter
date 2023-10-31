import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movies_app_flutter/models/movie.dart';
import 'package:movies_app_flutter/shared/result.dart';

class MovieService {
  final String _baseUrl =
      'https://api.themoviedb.org/3/movie/';
  final String _apiKey = '?api_key=3cae426b920b29ed2fb1c0749f258325';

  Future<Result> getAll(String endpoint) async {
    http.Response response = await http.get(Uri.parse('$_baseUrl$endpoint$_apiKey'));
    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      final List maps = jsonResponse['results'];
      final data = maps.map((map) => Movie.fromJson(map)).toList();
      return Result(
        success: true,
        data: data,
        message: 'Success',
      );
    }
    return const Result(
      success: false,
      data: null,
      message: 'API error',
    );
  }
}
