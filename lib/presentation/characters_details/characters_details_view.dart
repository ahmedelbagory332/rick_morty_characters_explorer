import 'package:flutter/material.dart';
import 'package:rick_morty_characters_explorer/domain/Characters/entity/characters_model.dart';
import 'package:rick_morty_characters_explorer/presentation/characters_details/widget/characters_details_view_body.dart';

class CharactersDetailsView extends StatelessWidget {
  const CharactersDetailsView({super.key, required this.characterItem});

  final CharacterItem characterItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Character Details"),
      ),
      body: CharactersDetailsViewBody(characterItem: characterItem),
    );
  }
}
