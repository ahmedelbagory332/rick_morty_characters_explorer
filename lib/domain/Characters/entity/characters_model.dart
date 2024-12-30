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
  final String type;
  final String gender;
  final String originLocation;
  final String currentLocation;
  final List<String> episodes;

  CharacterItem({
    required this.id,
    required this.avatarImage,
    required this.name,
    required this.species,
    required this.status,
    required this.type,
    required this.gender,
    required this.originLocation,
    required this.currentLocation,
    required this.episodes,
  });
}
