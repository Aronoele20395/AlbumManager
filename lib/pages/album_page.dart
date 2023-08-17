import 'package:album_manager/models/album.dart';
import 'package:album_manager/models/photo.dart';
import 'package:album_manager/models/user.dart';
import 'package:album_manager/utils/album_provider.dart';
import 'package:album_manager/utils/network_manager.dart';
import 'package:album_manager/utils/user_provider.dart';
import 'package:album_manager/widgets/photo_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDesktop = GetPlatform.isDesktop;

    final selectedAlbumProvider = Provider.of<AlbumProvider>(context);
    final selectedUserProvider = Provider.of<UserProvider>(context);
    final Album? selectedAlbum = selectedAlbumProvider.selectedAlbum;
    int? userId = selectedAlbum?.userId;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                selectedAlbum!.title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 1,
              child: FutureBuilder<User>(
                  future: NetworkManager().getUserById(userId!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError || !snapshot.hasData) {
                      return const Center(child: Text("Errore"));
                    } else {
                      return TextButton(
                          onPressed: () {
                            selectedUserProvider.setSelectedUser(snapshot.data!);
                            context.pushNamed('user_page');
                          },
                          child: Text(snapshot.data!.name));
                    }
                  }),
            )
          ],
        ),
      ),
      body: FutureBuilder<List<Photo>>(
        future: NetworkManager().getAlbumPhotos(selectedAlbum.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Errore nel caricamento delle foto"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nessuna foto disponibile"));
          } else {
            return CustomScrollView(slivers: [
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final photo = snapshot.data![index];
                    return PhotoCard(photo);
                  },
                  childCount: snapshot.data!.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDesktop ? 6 : 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 2.0,
                ),
              ),
            ]);
          }
        },
      ),
    );
  }
}
