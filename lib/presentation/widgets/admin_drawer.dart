import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';

Widget adminAppDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(
          height: 64,
        ),
        ListTile(
          leading: const Icon(
            Icons.dashboard_outlined,
          ),
          title: const Text('Dashbaord'),
          onTap: () {
            context.goNamed("dashboard");
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.shopping_bag_outlined,
          ),
          title: const Text('Products'),
          onTap: () {
            context.goNamed("products");
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.account_balance_wallet_outlined,
          ),
          title: const Text('Orders'),
          onTap: () {
            context.goNamed("order");
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.person_outline_rounded,
          ),
          title: const Text('Users'),
          onTap: () {
            context.goNamed("user");
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.logout_outlined,
          ),
          title: const Text('Logout'),
          onTap: () {
            // Restart app and go back to login screen
            Restart.restartApp();
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
