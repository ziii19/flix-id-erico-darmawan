import '../../../domain/usecases/get_actors/get_actors.dart';
import '../repositories/movie_repo/movie_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_actors_prov.g.dart';

@riverpod
GetActors getActors(GetActorsRef ref) =>
    GetActors(movieRepository: ref.watch(movieRepositoryProvider));
