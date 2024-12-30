import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../app/failures.dart';
import '../../../data/Characters/local/entity/characters_local_model.dart';
import '../../../domain/Characters/entity/characters_model.dart';
import '../../../domain/Characters/entity/status.dart';
import '../../../domain/Characters/repo/characters_repo.dart';
import 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(this.charactersRepo) : super(CharactersState.initial()){
    getAllLocalCharacters();
  }

  final CharactersRepo charactersRepo;
  final PagingController<int, CharacterItem> pagingListController =
      PagingController(firstPageKey: 1);
  List<CharacterItem> _newItems = [];
  var _searchName = "";
  var _status = "";
  var _species = "";

  onSearchNameChange(String search) {
    _searchName = search;
  }

  onFilterChange(String filter) {
    if (filter.isEmpty) {
      _searchName = "";
      _status = "";
      _species = "";
      pagingListController.refresh();
      return;
    }
    if (_isFilterStatus(filter)) {
      _status = filter;
    } else {
      _species = filter;
    }
    pagingListController.refresh();
  }

  bool _isFilterStatus(String filter) {
    return Status.values.map((e) => e.name).contains(filter);
  }

  Future<void> getCharactersList({
    required int page,
    required PagingController<int, CharacterItem> pagingController,
  }) async {
    try {
      late Either<Failure, CharacterModel> result;

      result = await charactersRepo.getCharactersList(
          page: page, status: _status, name: _searchName, species: _species);

      result.fold((failure) {
        pagingController.error = failure.errMessage;
      }, (model) {
        _newItems = model.characterItem;
        if (model.info?.next == null) {
          pagingController.appendLastPage(_newItems);
        } else {
          final nextPageKey = page + 1;
          pagingController.appendPage(_newItems, nextPageKey);
        }
      });
    } catch (error) {
      pagingController.error = error;
    }
  }

  getAllLocalCharacters() async {
    var list = await charactersRepo.getAllCharacter();
    emit(state.copyWith(localList: list));
  }

  Future<void> onFavClick(CharacterItem favItem) async {
    if (state.localList.any((item) => item.id == favItem.id)) {
      charactersRepo.deleteCharacter(favItem.id).then((value){
        getAllLocalCharacters();
      });
    } else {
      charactersRepo
          .insertCharacter(LocalCharacter.fromMap({
        'id': favItem.id,
        'avatar_image': favItem.avatarImage,
        'name': favItem.name,
        'species': favItem.species,
        'status': favItem.status,
      })).then((value) {
        getAllLocalCharacters();
      });
    }
  }


  isFav(CharacterItem characterItem, List<LocalCharacter> localList)   {
    return state.localList.any((item) => item.id == characterItem.id);
  }

  void refresh() {
    pagingListController.refresh();
    getAllLocalCharacters();
  }
}
