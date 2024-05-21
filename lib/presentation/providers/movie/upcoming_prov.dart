import '../../../domain/entities/movie.dart';
import '../../../domain/entities/result.dart';
import '../../../domain/usecases/get_movie_list/get_movie_list.dart';
import '../../../domain/usecases/get_movie_list/get_movie_list_param.dart';
import '../usecases/get_movie_list_prov.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upcoming_prov.g.dart';

@Riverpod(keepAlive: true)
class Upcoming extends _$Upcoming {
  @override
  FutureOr<List<Movie>> build() => [];

  Future<void> getMovies({int page = 1}) async {
    state = const AsyncLoading();

    GetMovieList getMovieList = ref.read(getMovieListProvider);

    var result = await getMovieList(GetMovieListParam(
        category: MovieListCategories.upcoming, page: page));

    switch (result) {
      case Success(value: final movies):
        state = AsyncData(movies);
      case Failed(message: _):
        state = const AsyncData([]);
    }
  }
}
