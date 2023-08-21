import 'package:album_manager/models/user.dart';
import 'package:album_manager/utils/user_provider.dart';
import 'package:album_manager/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = GetPlatform.isDesktop;

    final userProvider = Provider.of<UserProvider>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: isDesktop
              ? () {
                  userProvider.setSelectedUser(user);
                  Utils.showUserDialog(context, user, true);
                }
              : () {
                  userProvider.setSelectedUser(user);
                  context.pushNamed("user_page");
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text(user.name)),
              IconButton(onPressed: () => Utils.showDeleteAlert(context, user.name), icon: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
