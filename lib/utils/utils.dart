import 'package:album_manager/models/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Utils {
  static void showDeleteAlert(BuildContext context, String element) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Attenzione"),
        content: Text("Sei sicuro di voler eliminare $element?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Si'),
          ),
        ],
      ),
    );
  }

  static void showUserDialog(BuildContext context, User user, bool showAlbums) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(user.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(user.email),
            Text(user.address.city),
            Text(user.address.zipcode),
            Text(user.address.street),
            Text(user.address.suite),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Chiudi'),
          ),
          showAlbums ? TextButton(
            onPressed: () => context.pushNamed('user_albums_page'),
            child: const Text('I miei album'),
          ) : const SizedBox(),
        ],
      ),
    );
  }
}