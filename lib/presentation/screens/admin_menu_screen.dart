import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_builder_app/presentation/widgets/drawer.dart';

class AdminMenuScreen extends StatefulWidget {
  const AdminMenuScreen({super.key, required this.title});
  final String title;

  @override
  State<AdminMenuScreen> createState() => _AdminMenuScreenState();
}

class _AdminMenuScreenState extends State<AdminMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: const Color(0xff2b2b2b),
      ),
      drawer: appDrawer(context),
      body: Center(
          child: Container(
              decoration: const BoxDecoration(color: Color(0xfff0f0f0)),
              padding: const EdgeInsets.all(16),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
                children: [
                  InkWell(
                    onTap: () {
                      context.goNamed("products");
                    },
                    child: const Card(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_bag_outlined,
                            size: 64, color: Colors.amber),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Products",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     context.goNamed("cart");
                  //   },
                  //   child: const Card(
                  //       child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Icon(
                  //         Icons.shopping_cart_outlined,
                  //         size: 64,
                  //         color: Colors.green,
                  //       ),
                  //       SizedBox(
                  //         height: 8,
                  //       ),
                  //       Text(
                  //         "Cart",
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //             fontSize: 24, fontWeight: FontWeight.bold),
                  //       )
                  //     ],
                  //   )),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     context.goNamed("checkout");
                  //   },
                  //   child: const Card(
                  //       child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Icon(
                  //         Icons.account_balance_wallet_outlined,
                  //         size: 64,
                  //         color: Colors.blue,
                  //       ),
                  //       SizedBox(
                  //         height: 8,
                  //       ),
                  //       Text(
                  //         "Checkout",
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //             fontSize: 24, fontWeight: FontWeight.bold),
                  //       )
                  //     ],
                  //   )),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     context.goNamed("profile");
                  //   },
                  //   child: const Card(
                  //       child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Icon(
                  //         Icons.person_outline_rounded,
                  //         size: 64,
                  //         color: Colors.teal,
                  //       ),
                  //       SizedBox(
                  //         height: 8,
                  //       ),
                  //       Text(
                  //         "Profile",
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //             fontSize: 24, fontWeight: FontWeight.bold),
                  //       )
                  //     ],
                  //   )),
                  // ),
                  InkWell(
                    onTap: () {
                      context.goNamed("order");
                    },
                    child: const Card(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delivery_dining_outlined,
                          size: 64,
                          color: Colors.indigo,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Order",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                  ),
                  InkWell(
                    onTap: () {
                      context.goNamed("about");
                    },
                    child: const Card(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.question_mark_rounded,
                          size: 64,
                          color: Colors.red,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Information",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                  ),
                ],
              ))),
    );
  }
}
