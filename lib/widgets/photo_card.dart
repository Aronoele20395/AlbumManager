import 'package:album_manager/models/photo.dart';
import 'package:flutter/material.dart';

class PhotoCard extends StatelessWidget {
  final Photo photo;

  const PhotoCard(this.photo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(flex: 2, child: Image.network(photo.thumbnailUrl)),
            Expanded(
              child: Text(photo.title, overflow: TextOverflow.clip),
            )
          ],
        ),
      ),
    );
  }
}
