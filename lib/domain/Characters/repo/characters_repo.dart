import 'package:dartz/dartz.dart';
import '../../../app/failures.dart';
import '../entity/characters_model.dart';

abstract class CharactersRepo {

  Future<Either<Failure, CharacterModel>> getCharactersList({
        required int page,
        required String name,
        required String status,
        required String species,
      });
}
