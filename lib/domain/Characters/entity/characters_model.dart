import 'package:rick_morty_characters_explorer/data/Characters/network_entity/characters_network_entity.dart';

class CharacterModel {
  final List<CharacterItem> characterItem;
  final Info? info;

  CharacterModel({
    required this.characterItem,
    required this.info,
  });
}

class CharacterItem {
  final int id;
  final String avatarImage;
  final String name;
  final String species;
  final String status;

  CharacterItem({
    required this.id,
    required this.avatarImage,
    required this.name,
    required this.species,
    required this.status,
  });
}
