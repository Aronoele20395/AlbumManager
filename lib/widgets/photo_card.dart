import 'package:album_manager/models/photo.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
            Expanded(
                flex: 2,
                child: Image.network(
                  scale: 0.2,
                  photo.thumbnailUrl,
                )),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(photo.title, maxLines: 3, overflow: TextOverflow.clip),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
