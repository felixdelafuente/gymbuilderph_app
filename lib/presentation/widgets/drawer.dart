import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_builder_app/bloc/login/login_state.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';

Widget appDrawer(BuildContext context) {
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
            Icons.shopping_cart_outlined,
          ),
          title: const Text('Cart'),
          onTap: () {
            context.goNamed("cart");
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.account_balance_wallet_outlined,
          ),
          title: const Text('Checkout'),
          onTap: () {
            context.goNamed("checkout");
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.person_outline_rounded,
          ),
          title: const Text('Profile'),
          onTap: () {
            context.goNamed("user");
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.delivery_dining_outlined,
          ),
          title: const Text('Order'),
          onTap: () {
            context.goNamed("order");
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.info_outline_rounded,
          ),
          title: const Text('About'),
          onTap: () {
            context.goNamed("about");
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
            final provider = Provider.of<LoginState>(context, listen: false);
            provider.loggedIn = false;
            provider.logout();
            Restart.restartApp();
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
