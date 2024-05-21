import '../../../domain/usecases/get_movie_detail.dart/get_movie_detail.dart';
import '../repositories/movie_repo/movie_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_movie_detail_prov.g.dart';

@riverpod
GetMovieDetail getMovieDetail(GetMovieDetailRef ref) =>
    GetMovieDetail(movieRepository: ref.watch(movieRepositoryProvider));
