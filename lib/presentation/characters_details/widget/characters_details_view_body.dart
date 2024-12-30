import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../domain/Characters/entity/characters_model.dart';
import '../../Characters/view/widget/status_color.dart';

class CharactersDetailsViewBody extends StatelessWidget {
  const CharactersDetailsViewBody({super.key, required this.characterItem});

  final CharacterItem characterItem;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: characterItem.avatarImage,
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(height: 8),
          buildText("Name: ${characterItem.name}", null),
          buildText("Status: ${characterItem.status}",
              getStatusColor(characterItem.status)),
          buildText("Species: ${characterItem.species}", null),
          if (characterItem.type.isNotEmpty)
            buildText("Type: ${characterItem.type}", null),
          buildText("gender: ${characterItem.gender}", null),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Episodes",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: episodeList(),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  GridView episodeList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns in the grid
        crossAxisSpacing: 8, // Spacing between columns
        mainAxisSpacing: 8, // Spacing between rows
        childAspectRatio: 2, // Aspect ratio of each grid item
      ),
      itemCount: characterItem.episodes.length,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Episode ${index + 1}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  Text buildText(String text, Color? color) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 18 ),
      textAlign: TextAlign.center,
    );
  }
}
