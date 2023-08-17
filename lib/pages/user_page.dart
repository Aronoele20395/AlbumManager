import 'package:album_manager/utils/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.selectedUser;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(user!.name, textAlign: TextAlign.center, overflow: TextOverflow.fade),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(user.email),
            Text(user.address.city),
            Text(user.address.zipcode),
            Text(user.address.street),
            Text(user.address.suite),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  context.pushNamed('user_albums_page');
                },
                child: const Text("I miei album"))
          ],
        ),
      ),
    );
  }
}
