import 'package:flutter/material.dart';
import 'package:rick_morty_characters_explorer/presentation/fav_characters/view/widget/fav_characters_view_body.dart';

class FavCharactersView extends StatelessWidget {
  const FavCharactersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Favourite Character List"),
      ),
      body: const FavCharactersViewBody(),
    );
  }
}
