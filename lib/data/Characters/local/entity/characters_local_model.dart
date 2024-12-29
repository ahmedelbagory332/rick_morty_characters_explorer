import '../../../../domain/Characters/entity/characters_model.dart';

class LocalCharacter {
  int? id;
  String? avatarImage;
  String? name;
  String? species;
  String? status;

  LocalCharacter.init();

  LocalCharacter(CharacterItem obj) {
    id = obj.id;
    avatarImage = obj.avatarImage;
    name = obj.name;
    species = obj.species;
    status = obj.status;
  }

  factory LocalCharacter.fromMap(Map<String, dynamic> map) {
    return LocalCharacter.init()
      ..id = map['id'] as int?
      ..avatarImage = map['avatar_image'] as String?
      ..name = map['name'] as String?
      ..species = map['species'] as String?
      ..status = map['status'] as String?;
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'avatar_image': avatarImage,
    'name': name,
    'species': species,
    'status': status
  };
}
