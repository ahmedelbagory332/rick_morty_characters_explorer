import 'package:dio/dio.dart';
import '../../data/Characters/repo_impl/characters_repo_impl.dart';
import '../../domain/Characters/repo/characters_repo.dart';
import '../api_service.dart';

Future<void> setupRepoServiceLocator(getIt) async {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));

  getIt.registerSingleton<CharactersRepo>(CharactersRepoImpl(
    getIt.get<ApiService>(),
  ));
}