import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rick_morty_characters_explorer/presentation/Characters/view/widget/search_bar.dart';
import 'package:rick_morty_characters_explorer/presentation/Characters/view/widget/status_color.dart';
import '../../../../domain/Characters/entity/characters_model.dart';
import '../../manager/characters_cubit.dart';

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
    context.read<CharactersCubit>().pagingListController.addPageRequestListener((pageKey) {
      _pageKey = pageKey;
      context.read<CharactersCubit>().getCharactersList(
          page: _pageKey, pagingController: context.read<CharactersCubit>().pagingListController);
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
          onSearch: (name){
            context.read<CharactersCubit>().pagingListController.refresh();
          },
          onChanged: (name){
            context.read<CharactersCubit>().onSearchNameChange(name);
            if(name.isEmpty) {
              context.read<CharactersCubit>().pagingListController.refresh();
            }
          },
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<CharactersCubit>().pagingListController.refresh();
            },
            child: PagedListView<int, CharacterItem>(
              pagingController: context.read<CharactersCubit>().pagingListController,
              builderDelegate: PagedChildBuilderDelegate<CharacterItem>(
                itemBuilder: (context, item, index) {
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    color: Theme.of(context).colorScheme.inversePrimary,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(

                        children: [
                          CircleAvatar(
                            radius: 40,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: item.avatarImage,
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text(item.species,
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: getStatusColor(item.status).withOpacity(.2),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Text(item.status,
                                      style: TextStyle(fontWeight: FontWeight.bold,color: getStatusColor(item.status))),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.favorite_border)
                        ],
                      ),
                    ),
                  );
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

class EmptyError extends StatelessWidget {
  const EmptyError({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}