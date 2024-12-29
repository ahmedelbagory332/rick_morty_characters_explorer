import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rick_morty_characters_explorer/data/Characters/local/entity/characters_local_model.dart';
import '../../../app/api_service.dart';
import '../../../app/failures.dart';
import '../../../data/Characters/network_entity/characters_network_entity.dart';
import '../../../domain/Characters/entity/characters_model.dart';
import '../../../domain/Characters/repo/characters_repo.dart';
import '../local/dbhelper.dart';

class CharactersRepoImpl implements CharactersRepo {
  CharactersRepoImpl(this.apiService, this.localStorage);

  final ApiService apiService;
  final DbHelper localStorage;

  @override
  Future<Either<Failure, CharacterModel>> getCharactersList(
      {required int page,
      required String name,
      required String status,
      required String species}) async {
    try {
      var response = await apiService.get(
        endPoint:
            'character/?page=$page&name=$name&status=$status&species=$species',
      );
      if (response.success) {
        var model = CharactersNetWorkEntity.fromJson(response.data);
        var characterItems = model.results!.map((result) {
          return CharacterItem(
            id: result.id ?? 0,
            avatarImage: result.image ?? "",
            name: result.name ?? "",
            species: result.species ?? "",
            status: result.status ?? "",
          );
        }).toList();

        return right(CharacterModel(characterItem: characterItems, info: model.info));
      } else {
        return left(Failure(response.errorMessage, response.code.toString()));
      }
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(ServerFailure(e.toString(), ""));
    }
  }

  @override
  Future<int> deleteCharacter(int id) {
    return localStorage.delete(id);
  }

  @override
  Future<int> insertCharacter(LocalCharacter localCharacter) {
    return localStorage.insertCharacter(localCharacter);
  }

  @override
  Future<List<LocalCharacter>> getAllCharacter() async {
    List<dynamic> result = await localStorage.allCharacters();
    return result.map((e) => LocalCharacter.fromMap(e as Map<String, dynamic>)).toList();
  }
}