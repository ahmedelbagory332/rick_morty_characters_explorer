import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rick_morty_characters_explorer/presentation/Characters/view/widget/character_list_item.dart';
import 'package:rick_morty_characters_explorer/presentation/Characters/view/widget/search_bar.dart';
import '../../../../domain/Characters/entity/characters_model.dart';
import '../../manager/characters_cubit.dart';
import 'empty_error.dart';

class CharactersViewBody extends StatefulWidget {
  const CharactersViewBody({super.key});

  @override
  State<CharactersViewBody> createState() => _CharactersViewBodyState();
}

class _CharactersViewBodyState extends State<CharactersViewBody> {
  final TextEditingController _searchController = TextEditingController();
  int _pageKey = 1;

  @override
  void initState() {
    context
        .read<CharactersCubit>()
        .pagingListController
        .addPageRequestListener((pageKey) {
      _pageKey = pageKey;
      context.read<CharactersCubit>().getCharactersList(
          page: _pageKey,
          pagingController:
              context.read<CharactersCubit>().pagingListController);
    });
    super.initState();
  }

  @override
  void dispose() {
    context.read<CharactersCubit>().pagingListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextEditSearchBar(
          controller: _searchController,
          onSearch: (name) {
            context.read<CharactersCubit>().pagingListController.refresh();
          },
          onChanged: (name) {
            context.read<CharactersCubit>().onSearchNameChange(name);
            if (name.isEmpty) {
              context.read<CharactersCubit>().pagingListController.refresh();
            }
          },
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<CharactersCubit>().refresh();
            },
            child: PagedListView<int, CharacterItem>(
              pagingController:
                  context.read<CharactersCubit>().pagingListController,
              builderDelegate: PagedChildBuilderDelegate<CharacterItem>(
                itemBuilder: (context, item, index) {
                  return characterListItem(context, item,(favItem) {
                    context.read<CharactersCubit>().onFavClick(favItem);
                  },);
                },
                noItemsFoundIndicatorBuilder: (BuildContext context) {
                  return const EmptyError(text: "No Data");
                },
                firstPageErrorIndicatorBuilder: (BuildContext context) {
                  return const EmptyError(text: "error happened");
                },
                firstPageProgressIndicatorBuilder: (BuildContext context) {
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
