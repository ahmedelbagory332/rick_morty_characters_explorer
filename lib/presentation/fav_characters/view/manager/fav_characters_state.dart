import 'package:equatable/equatable.dart';
import '../../../../data/Characters/local/entity/characters_local_model.dart';

class FavCharactersState extends Equatable {
  final List<LocalCharacter> localList;

  const FavCharactersState({
    required this.localList,
  });

  factory FavCharactersState.initial() {
    return const FavCharactersState(
      localList: [],
    );
  }

  @override
  List<Object> get props => [localList];

  FavCharactersState copyWith({List<LocalCharacter>? localList}) {
    return FavCharactersState(localList: localList ?? this.localList);
  }
}
