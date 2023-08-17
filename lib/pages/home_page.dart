import 'package:album_manager/models/album.dart';
import 'package:album_manager/models/user.dart';
import 'package:album_manager/utils/network_manager.dart';
import 'package:album_manager/widgets/album_card.dart';
import 'package:album_manager/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDesktop = GetPlatform.isDesktop;

  late final Future<List<Album>> albums;
  late final Future<List<User>> users;

  @override
  void initState() {
    albums = NetworkManager().getAlbums();
    users = NetworkManager().getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Album Manager"),
          bottom: const TabBar(tabs: [
            Tab(text: "Utenti"),
            Tab(text: "Album"),
          ]),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: <Widget>[
              FutureBuilder<List<User>>(
                future: users,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Errore nel caricamento degli utenti"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Nessun utente disponibile"));
                  } else {
                    return CustomScrollView(slivers: [
                      SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final user = snapshot.data![index];
                            return UserCard(user);
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
              FutureBuilder<List<Album>>(
                future: albums,
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
            ],
          ),
        ),
      ),
    );
  }
}
