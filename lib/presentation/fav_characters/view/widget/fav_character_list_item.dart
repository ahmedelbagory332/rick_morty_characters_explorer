import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_characters_explorer/data/Characters/local/entity/characters_local_model.dart';
import 'package:rick_morty_characters_explorer/presentation/Characters/view/widget/status_color.dart';

Card favCharacterListItem(
    BuildContext context, LocalCharacter item, Function(LocalCharacter) favItem) {
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
                imageUrl: item.avatarImage ?? "",
                fit: BoxFit.cover,
                width: 80,
                height: 80,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
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
                Text(item.name ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(item.species ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                      color: getStatusColor(item.status ?? "").withOpacity(.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(item.status ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: getStatusColor(item.status ?? ""))),
                ),
              ],
            ),
          ),
          InkWell(
              onTap: () {
                favItem(item);
              },
              child: const Icon(Icons.favorite))
        ],
      ),
    ),
  );
}