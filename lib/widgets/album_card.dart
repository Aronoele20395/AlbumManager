import 'package:album_manager/models/album.dart';
import 'package:album_manager/utils/album_provider.dart';
import 'package:album_manager/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AlbumCard extends StatelessWidget {
  final Album album;

  const AlbumCard(this.album, {super.key});

  @override
  Widget build(BuildContext context) {
    final albumProvider = Provider.of<AlbumProvider>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            albumProvider.setSelectedAlbum(album);
            context.pushNamed('album_page');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  album.title,
                  overflow: TextOverflow.fade,
                ),
              ),
              IconButton(
                onPressed: () => Utils.showDeleteAlert(context, album.title),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
