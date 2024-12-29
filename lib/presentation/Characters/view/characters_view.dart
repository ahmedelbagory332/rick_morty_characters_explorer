import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_characters_explorer/app/app_router.dart';
import 'package:rick_morty_characters_explorer/presentation/Characters/view/widget/characters_view_body.dart';

import '../manager/characters_cubit.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  late CharactersCubit cubit;

  @override
  void initState() {
    cubit = context.read<CharactersCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Character List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () async {
              await GoRouter.of(context).push(AppRouter.kFavCharactersView);
              cubit.getAllLocalCharacters();
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              context.read<CharactersCubit>().onFilterChange(value);
            },
            itemBuilder: (BuildContext context) {
              return filterList();
            },
            icon: const Icon(Icons.filter_list_alt), // Menu icon
          ),
        ],
      ),
      body: const CharactersViewBody(),
    );
  }

  List<PopupMenuEntry<String>> filterList() {
    return [
      const PopupMenuItem(
        value: 'alien',
        child: Text('Alien'),
      ),
      const PopupMenuItem(
        value: 'human',
        child: Text('Human'),
      ),
      const PopupMenuItem(
        value: 'unknown',
        child: Text('UnKnown'),
      ),
      const PopupMenuItem(
        value: 'dead',
        child: Text('Dead'),
      ),
      const PopupMenuItem(
        value: 'alive,',
        child: Text('Alive'),
      ),
      const PopupMenuItem(
        value: '',
        child: Text('Reset Filter'),
      ),
    ];
  }
}
