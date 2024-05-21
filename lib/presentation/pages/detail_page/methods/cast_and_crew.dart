import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/movie.dart';
import '../../../misc/methods.dart';
import '../../../providers/movie/actors_prov.dart';
import '../../../widgets/network_image_card.dart';

List<Widget> castAndCrew({required Movie movie, required WidgetRef ref}) => [
      const Padding(
        padding: EdgeInsets.only(left: 24),
        child: Text(
          'Cast and crew',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      verticalSpace(10),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            horizontalSpaces(24),
            ...(ref.watch(actorsProvider(movieId: movie.id)).whenOrNull(
                      data: (data) => data
                          .where((element) => element.profilePath != null)
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    NetworkImageCard(
                                      width: 100,
                                      height: 152,
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/w185/${e.profilePath}',
                                      fit: BoxFit.cover,
                                    ),
                                    verticalSpace(5),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        e.name,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                    ) ??
                []),
            horizontalSpaces(14)
          ],
        ),
      )
    ];
