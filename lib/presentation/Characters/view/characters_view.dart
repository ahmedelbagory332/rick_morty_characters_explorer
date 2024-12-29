import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_characters_explorer/presentation/Characters/view/widget/characters_view_body.dart';

import '../manager/characters_cubit.dart';

class CharactersView extends StatelessWidget {
  const CharactersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Character List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {

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
