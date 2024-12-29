import 'package:equatable/equatable.dart';
import '../../../app/failures.dart';
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

  const CharactersState({
    required this.characterListStatus,
    required this.error,
  });

  factory CharactersState.initial() {
    return const CharactersState(
      characterListStatus: CharacterListStatus.initial,
      error: Failure("", ""),
    );
  }

  @override
  List<Object> get props => [characterListStatus, error];

  CharactersState copyWith(
      {List<CharacterItem>? characterList,
      CharacterListStatus? characterListStatus,
      Failure? error}) {
    return CharactersState(
        characterListStatus: characterListStatus ?? this.characterListStatus,
        error: error ?? this.error);
  }
}