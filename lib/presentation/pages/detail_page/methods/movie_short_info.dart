import '../../../../domain/entities/movie_detail.dart';
import '../../../misc/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> movieShortInfo(
        {required AsyncValue<MovieDetail?> asyncMovieDetail,
        required BuildContext context}) =>
    [
      Row(
        children: [
          SizedBox(
            height: 14,
            width: 14,
            child: Image.asset('assets/duration.png'),
          ),
          horizontalSpaces(5),
          SizedBox(
            width: 90,
            child: Text('${asyncMovieDetail.when(
              data: (data) => data != null ? data.runtime : '',
              error: (error, stackTrace) => '-',
              loading: () => '-',
            )} minutes'),
          ),
          SizedBox(
            width: 14,
            height: 14,
            child: Image.asset('assets/genre.png'),
          ),
          horizontalSpaces(5),
          SizedBox(
            width: MediaQuery.of(context).size.width - 48 - 95 - 14 - 14 - 10,
            child: asyncMovieDetail.when(
              data: (data) {
                String genres = data?.genres.join(', ') ?? '-';

                return Text(
                  genres,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                );
              },
              error: (error, stackTrace) => const Text(
                '-',
                style: TextStyle(fontSize: 12),
              ),
              loading: () => const Text(
                '-',
                style: TextStyle(fontSize: 12),
              ),
            ),
          )
        ],
      ),
      verticalSpace(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 18,
            width: 18,
            child: Image.asset('assets/star.png'),
          ),
          horizontalSpaces(5),
          Text((asyncMovieDetail.valueOrNull?.voteAverage ?? 0)
              .toStringAsFixed(1))
        ],
      )
    ];
