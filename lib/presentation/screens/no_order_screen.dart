import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoOrderScreen extends StatefulWidget {
  const NoOrderScreen({Key? key}) : super(key: key);

  @override
  _NoOrderScreenState createState() => _NoOrderScreenState();
}

class _NoOrderScreenState extends State<NoOrderScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      context.goNamed("menu");
    });
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.goNamed("menu"),
        ),
        title: const Text("Your Order"),
        centerTitle: true,
        backgroundColor: const Color(0xff2b2b2b),
      ),
      body: const Center(
        child: Text(
            "You have no ongoing orders."), // The text to show in the center
      ),
    );
  }
}
