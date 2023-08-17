import 'package:album_manager/pages/album_page.dart';
import 'package:album_manager/pages/home_page.dart';
import 'package:album_manager/pages/user_albums_page.dart';
import 'package:album_manager/pages/user_page.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: 'user_page',
      path: '/user_page',
      builder: (context, state) => const UserPage(),
    ),
    GoRoute(
      name: 'album_page',
      path: '/album_page',
      builder: (context, state) => const AlbumPage(),
    ),
    GoRoute(
      name: 'user_albums_page',
      path: '/user_albums_page',
      builder: (context, state) => const UserAlbums(),
    ),
  ],
);
