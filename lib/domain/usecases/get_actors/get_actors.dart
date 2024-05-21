import '../../../data/repositories/movie_repository.dart';
import '../../entities/actor.dart';
import '../../entities/result.dart';
import 'get_actors_param.dart';
import '../usecases.dart';

class GetActors implements UseCase<Result<List<Actor>>, GetActorParam> {
  final MovieRepository _movieRepository;

  GetActors({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;
  @override
  Future<Result<List<Actor>>> call(GetActorParam params) async {
    var actorListResult = await _movieRepository.getActor(id: params.movieId);

    return switch (actorListResult) {
      Success(value: final actorList) => Result.success(actorList),
      Failed(:final message) => Result.failed(message)
    };
  }
}
