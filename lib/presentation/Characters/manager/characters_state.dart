import 'package:equatable/equatable.dart';
import '../../../app/failures.dart';
import '../../../data/Characters/local/entity/characters_local_model.dart';
import '../../../domain/Characters/entity/characters_model.dart';

enum CharacterListStatus {
  initial,
  loading,
  success,
  error,
}

class CharactersState extends Equatable {
  final CharacterListStatus characterListStatus;
  final Failure error;
  final List<LocalCharacter> localList;

  const CharactersState({
    required this.characterListStatus,
    required this.error,
    required this.localList,
  });

  factory CharactersState.initial() {
    return const CharactersState(
      characterListStatus: CharacterListStatus.initial,
      error: Failure("", ""),
      localList: [],
    );
  }

  @override
  List<Object> get props => [characterListStatus, error, localList];

  CharactersState copyWith(
      {List<LocalCharacter>? localList,
      CharacterListStatus? characterListStatus,
      Failure? error}) {
    return CharactersState(
        characterListStatus: characterListStatus ?? this.characterListStatus,
        localList: localList ?? this.localList,
        error: error ?? this.error);
  }
}