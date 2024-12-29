import 'package:dartz/dartz.dart';
import '../../../app/failures.dart';
import '../../../data/Characters/local/entity/characters_local_model.dart';
import '../entity/characters_model.dart';

abstract class CharactersRepo {

  Future<Either<Failure, CharacterModel>> getCharactersList({
        required int page,
        required String name,
        required String status,
        required String species,
      });
  Future<int> insertCharacter(LocalCharacter localCharacter);
  Future<int> deleteCharacter(int id);
  Future<List<LocalCharacter>> getAllCharacter();
}
