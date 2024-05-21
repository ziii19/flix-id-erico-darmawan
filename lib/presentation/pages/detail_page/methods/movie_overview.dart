import '../../../../domain/entities/movie_detail.dart';
import '../../../misc/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> movieOverview(AsyncValue<MovieDetail?> asyncMovieDetail) => [
      const Text(
        'Overview',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      verticalSpace(10),
      asyncMovieDetail.when(
        data: (data) => Text(data != null ? data.overview : ''),
        error: (error, stackTrace) => const Text(
            "Failed to load movie's overview. Please try again later."),
        loading: () => const CircularProgressIndicator(),
      )
    ];
