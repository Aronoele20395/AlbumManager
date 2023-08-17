import 'package:album_manager/models/album.dart';
import 'package:album_manager/utils/network_manager.dart';
import 'package:album_manager/utils/user_provider.dart';
import 'package:album_manager/widgets/album_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAlbums extends StatelessWidget {
  const UserAlbums({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.selectedUser;

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Album>>(
        future: NetworkManager().getAlbumsByUser(user!.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Errore nel caricamento degli album"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nessun album disponibile"));
          } else {
            return CustomScrollView(slivers: [
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final album = snapshot.data![index];
                    return AlbumCard(album);
                  },
                  childCount: snapshot.data!.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
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
