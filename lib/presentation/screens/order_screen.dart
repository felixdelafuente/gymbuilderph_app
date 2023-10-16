import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_builder_app/bloc/order/order_bloc.dart';
import 'package:gym_builder_app/bloc/products/products_bloc.dart';
import 'package:gym_builder_app/data/models/order_model.dart';
import 'package:gym_builder_app/data/models/products_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key, required this.title});
  final String title;

  @override
  State<OrderScreen> createState() => _OrderScreen();
}

class _OrderScreen extends State<OrderScreen> {
  late OrderBloc orderBloc;
  late ProductsBloc _productsBloc;

  @override
  void initState() {
    // Use the context of this widget to access the OrderBloc instance
    orderBloc = BlocProvider.of<OrderBloc>(context);
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
      if (state is OrderLoadingState) {
        print("loading: $state");
      } else if (state is OrderErrorState) {
        context.pushNamed("no-order");
        print("error: $state");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "You cannot cancel your order since the package is already on the way."), // Show a message that says the order cannot be cancelled
            duration:
                Duration(seconds: 3), // How long the message will be displayed
          ),
        );
        context.goNamed("no-order");
      } else if (state is OrderLoadedState) {
        print("loaded: $state");

        List<OrderModel> orderList = state.order;

        if (orderList.isEmpty) {
          Future.delayed(const Duration(seconds: 3), () {
            print("inside orderList.Empty 1");
            context.goNamed("main-menu");
            // context.push("/main-menu");
          });
        }

        return orderItems(context, orderList);
      } else {
        context.goNamed("no-order");
      }
      context.goNamed("no-order");
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => context.pushNamed("menu"),
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
    });
  }

  Widget orderItems(BuildContext _, List<OrderModel> orderList) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (_, productsState) {
        if (productsState is ProductsLoadingState) {
          print("loading: $productsState");
        } else if (productsState is ProductsErrorState) {
          print("error: $productsState");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  "You cannot cancel your order since the package is already on the way."), // Show a message that says the order cannot be cancelled
              duration: Duration(
                  seconds: 3), // How long the message will be displayed
            ),
          );
          context.goNamed("no-order");
        } else if (productsState is ProductsLoadedState) {
          // print("loaded: $productsState");

          // if (orderList.isEmpty) {
          //   Future.delayed(const Duration(seconds: 3), () {
          //     print("inside orderList.Empty 2");
          //     context.goNamed("main-menu");
          //     // context.push("/main-menu");
          //   });
          // }

          // Create a map to store the lowest order id for each product id
          Map<String, int> lowestOrderId = {};

          // Create a map to store the total quantity for each product id
          Map<String, int> totalQuantity = {};

          // Loop through the order list and update the maps
          for (OrderModel order in orderList) {
            // Get the current product id and quantity
            String productId = order.productId.toString();
            int quantity = int.parse(order.quantity.toString());

            // Check if the product id is already in the maps
            if (lowestOrderId.containsKey(productId)) {
              // Update the lowest order id if the current one is smaller
              if (int.parse(order.orderId.toString()) <
                  int.parse(lowestOrderId[productId].toString())) {
                lowestOrderId[productId] = int.parse(order.orderId.toString());
              }

              // Add the current quantity to the total quantity
              totalQuantity[productId] = (totalQuantity[productId]! + quantity);
            } else {
              // Initialize the maps with the current values
              lowestOrderId[productId] = int.parse(order.orderId.toString());
              totalQuantity[productId] = quantity;
            }
          }

          // Loop through the order list again and modify the quantity
          for (OrderModel order in orderList) {
            // Get the current product id and order id
            String productId = order.productId.toString();
            int orderId = int.parse(order.orderId.toString());

            // Check if the current order id is the lowest for the product id
            if (orderId == lowestOrderId[productId]) {
              // Set the quantity to the total quantity
              order.quantity = totalQuantity[productId].toString();
            } else {
              // Set the quantity to zero
              order.quantity = "0";
            }
          }

          List<ProductsModel> productsList = productsState.products;

          // Create a set of product_ids from the orderList
          Set<String?> productIdsInOrder =
              orderList.map((order) => order.productId.toString()).toSet();

          // Filter the productsList using the where method
          List<ProductsModel> filteredProducts = productsList.where((product) {
            // Return true if the product_id is in the set
            return productIdsInOrder.contains(product.productId);
          }).toList();

          print("filtered products: $filteredProducts");

          // Use the fold method to calculate the total price
          double totalPrice = filteredProducts.fold(
            0.0, // Initial value
            (sum, product) =>
                sum +
                (double.parse(product.price.toString()) *
                    double.parse(product.item
                        .toString())), // Function to apply to each element
          );

          // if (orderList == []) {
          //   context.goNamed("no-order");
          // }

          String firstItem = orderList.isNotEmpty
              ? orderList.first.deliveryStatus.toString()
              : "N/A";

          String firstTotal = orderList.isNotEmpty
              ? orderList.first.totalAmount.toString()
              : "N/A";

          if (firstItem == "cancelled") {
            OrderBloc().add(DeleteOrderEvent(
                orderId: int.parse(orderList.first.orderId.toString())));
          }

          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => context.pushNamed("menu"),
              ),
              title: const Text("Your Order"),
              centerTitle: true,
              backgroundColor: const Color(0xff2b2b2b),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.builder(
                    // Set the item count as the length of the order items list
                    itemCount: filteredProducts.length,
                    // Use an itemBuilder function to return the widgets for each item
                    itemBuilder: (context, index) {
                      // Get the current item from the list
                      final item = filteredProducts[index];
                      // Return a ListTile widget that displays the image, name, price, quantity, and x button of the item

                      double itemFinalPrice = double.parse(
                              item.price.toString()) *
                          double.parse(orderList[index].quantity.toString());
                      return ListTile(
                        leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              "http://gymbuilderph.com${item.imageLink.toString()}",
                              height: 40,
                              errorBuilder: (_, error, stackTrace) {
                                return const Icon(Icons.shopping_bag_outlined);
                              },
                            ),
                          ],
                        ),
                        title: Text(item.name.toString()),
                        subtitle: Text('$itemFinalPrice'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Qty: "),
                            Text('${orderList[index].quantity}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child: Text(
                    "Order Status: $firstItem",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child: Text(
                    "Total: $firstTotal",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: _,
                        builder: (_) {
                          return AlertDialog(
                            content: const Text(
                                'Are you sure you want to cancel your order?'),
                            actions: [
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () {
                                  // Remove the item from the cart
                                  // OrderBloc().add(DeleteOrder(
                                  //     cartId: int.parse(
                                  //         cartList[index].cartId.toString())));

                                  if (firstItem != "processing") {
                                    // Navigator.of(context)
                                    //     .pop(); // Close the dialog
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "You cannot cancel your order since the package is already on the way."), // Show a message that says the order cannot be cancelled
                                        duration: Duration(
                                            seconds:
                                                3), // How long the message will be displayed
                                      ),
                                    );
                                  } else if (firstItem == "cancelled") {
                                    OrderBloc().add(DeleteOrderEvent(
                                        orderId: int.parse(orderList
                                            .first.orderId
                                            .toString())));
                                  } else {
                                    OrderBloc().add(DeleteOrderEvent(
                                        orderId: int.parse(orderList
                                            .first.orderId
                                            .toString())));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Order canceled successfully."), // Show a message that says the order cannot be cancelled
                                        duration: Duration(
                                            seconds:
                                                3), // How long the message will be displayed
                                      ),
                                    );
                                    Future.delayed(const Duration(seconds: 3),
                                        () {
                                      context.goNamed("menu");
                                    });
                                  }
                                },
                              ),
                              TextButton(
                                child: const Text('No'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                              ),
                            ],
                          );
                        });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black87),
                  ),
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.white)),
                )),
          );
        } else {
          context.goNamed("no-order");
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => context.pushNamed("menu"),
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
        context.goNamed("no-order");
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => context.pushNamed("menu"),
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
      },
    );
  }
}
