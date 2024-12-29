import 'package:bloc/bloc.dart';
import '../../../../data/Characters/local/entity/characters_local_model.dart';
import '../../../../domain/Characters/repo/characters_repo.dart';
import 'fav_characters_state.dart';

class FavCharactersCubit extends Cubit<FavCharactersState> {
  FavCharactersCubit(this.charactersRepo)
      : super(FavCharactersState.initial()) {
    getAllLocalCharacters();
  }

  final CharactersRepo charactersRepo;

  getAllLocalCharacters() async {
    var list = await charactersRepo.getAllCharacter();
    emit(state.copyWith(localList: list));
  }

  Future<void> onFavClick(LocalCharacter favItem) async {
    charactersRepo.deleteCharacter(favItem.id ?? 0).then((value) {
      getAllLocalCharacters();
    });
  }
}
