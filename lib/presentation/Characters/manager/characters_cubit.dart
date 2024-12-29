import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../app/failures.dart';
import '../../../domain/Characters/entity/characters_model.dart';
import '../../../domain/Characters/entity/status.dart';
import '../../../domain/Characters/repo/characters_repo.dart';
import 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(this.charactersRepo) : super(CharactersState.initial());
  final CharactersRepo charactersRepo;
  final PagingController<int, CharacterItem> pagingListController =
  PagingController(firstPageKey: 1);
  List<CharacterItem> _newItems = [];
  var searchName = "";
  var status = "";
  var species = "";

  onSearchNameChange(String search) {
    searchName = search;
  }

  onFilterChange(String filter) {
    if (filter.isEmpty) {
      searchName = "";
      status = "";
      species = "";
      pagingListController.refresh();
      return;
    }
    if (_isFilterStatus(filter)) {
      status = filter;
    } else {
      species = filter;
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
          page: page, status: status, name: searchName, species: species);

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
}
