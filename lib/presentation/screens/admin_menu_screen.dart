import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_builder_app/presentation/widgets/admin_drawer.dart';

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
      drawer: adminAppDrawer(context),
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
                      print("card tapped");
                      context.goNamed("admin-dashboard");
                    },
                    child: const Card(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.analytics_outlined,
                            size: 64, color: Colors.green),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Dashboard",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                  ),
                  InkWell(
                    onTap: () {
                      print("card tapped");
                      context.goNamed("admin-products");
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
                  InkWell(
                    onTap: () {
                      print("card tapped");
                      context.goNamed("admin-order");
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
                          "Orders",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                  ),
                  InkWell(
                    onTap: () {
                      print("card tapped");
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
                  // InkWell(
                  //   onTap: () {
                  //     context.goNamed("users");
                  //   },
                  //   child: const Card(
                  //       child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Icon(
                  //         Icons.groups_2_outlined,
                  //         size: 64,
                  //         color: Colors.teal,
                  //       ),
                  //       SizedBox(
                  //         height: 8,
                  //       ),
                  //       Text(
                  //         "Users",
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //             fontSize: 24, fontWeight: FontWeight.bold),
                  //       )
                  //     ],
                  //   )),
                  // ),
                ],
              ))),
    );
  }
}
