import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_builder_app/bloc/cart/cart_bloc.dart';
import 'package:gym_builder_app/bloc/products/products_bloc.dart';
import 'package:gym_builder_app/data/models/cart_model.dart';
import 'package:gym_builder_app/data/models/products_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.title});
  final String title;

  @override
  State<CartScreen> createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen> {
  late CartBloc cartBloc;
  late ProductsBloc _productsBloc;

  @override
  void initState() {
    // Use the context of this widget to access the CartBloc instance
    cartBloc = BlocProvider.of<CartBloc>(context);
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      if (state is CartLoadingState) {
        print("loading: $state");
      } else if (state is CartErrorState) {
        print("error: $state");
      } else if (state is CartLoadedState) {
        print("loaded: $state");

        List<CartModel> cartList = state.cart;

        return cartItems(context, cartList);
      } else {
        return Container();
      }
      return Container();
    });
  }

  Widget cartItems(BuildContext _, List<CartModel> cartList) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (_, productsState) {
        if (productsState is ProductsLoadingState) {
          print("loading: $productsState");
        } else if (productsState is ProductsErrorState) {
          print("error: $productsState");
        } else if (productsState is ProductsLoadedState) {
          // print("loaded: $productsState");

          // Create a map to store the lowest cart id for each product id
          Map<String, int> lowestCartId = {};

          // Create a map to store the total quantity for each product id
          Map<String, int> totalQuantity = {};

          // Loop through the cart list and update the maps
          for (CartModel cart in cartList) {
            // Get the current product id and quantity
            String productId = cart.productId.toString();
            int quantity = int.parse(cart.quantity.toString());

            // Check if the product id is already in the maps
            if (lowestCartId.containsKey(productId)) {
              // Update the lowest cart id if the current one is smaller
              if (int.parse(cart.cartId.toString()) <
                  int.parse(lowestCartId[productId].toString())) {
                lowestCartId[productId] = int.parse(cart.cartId.toString());
              }

              // Add the current quantity to the total quantity
              totalQuantity[productId] = (totalQuantity[productId]! + quantity);
            } else {
              // Initialize the maps with the current values
              lowestCartId[productId] = int.parse(cart.cartId.toString());
              totalQuantity[productId] = quantity;
            }
          }

          // Loop through the cart list again and modify the quantity
          for (CartModel cart in cartList) {
            // Get the current product id and cart id
            String productId = cart.productId.toString();
            int cartId = int.parse(cart.cartId.toString());

            // Check if the current cart id is the lowest for the product id
            if (cartId == lowestCartId[productId]) {
              // Set the quantity to the total quantity
              cart.quantity = totalQuantity[productId];
            } else {
              // Set the quantity to zero
              cart.quantity = 0;
            }
          }
          print("quantityzzz: ${cartList.map((e) => e.quantity)}");

          List<ProductsModel> productsList = productsState.products;

          // Create a set of product_ids from the cartList
          Set<int?> productIdsInCart =
              cartList.map((cart) => cart.productId).toSet();

          // Filter the productsList using the where method
          List<ProductsModel> filteredProducts = productsList.where((product) {
            // Return true if the product_id is in the set
            return productIdsInCart.contains(product.productId);
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

          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => context.pushNamed("menu"),
              ),
              title: const Text("Your Cart"),
              centerTitle: true,
              backgroundColor: const Color(0xff2b2b2b),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.builder(
                    // Set the item count as the length of the cart items list
                    itemCount: filteredProducts.length,
                    // Use an itemBuilder function to return the widgets for each item
                    itemBuilder: (context, index) {
                      // Get the current item from the list
                      final item = filteredProducts[index];
                      // Return a ListTile widget that displays the image, name, price, quantity, and x button of the item

                      double itemFinalPrice =
                          double.parse(item.price.toString()) *
                              double.parse(cartList[index].quantity.toString());
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
                            Text('${cartList[index].quantity}'),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                showDialog(
                                    context: _,
                                    builder: (_) {
                                      return AlertDialog(
                                        content: const Text(
                                            'Are you sure you want to remove this item from the cart?'),
                                        actions: [
                                          TextButton(
                                            child: const Text('Yes'),
                                            onPressed: () {
                                              // Remove the item from the cart
                                              CartBloc().add(DeleteCartEvent(
                                                  cartId: int.parse(
                                                      cartList[index]
                                                          .cartId
                                                          .toString())));

                                              Future.delayed(
                                                  const Duration(seconds: 1),
                                                  () {
                                                //context.goNamed(colorProductsRouteName);
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MultiBlocProvider(
                                                            providers: [
                                                              BlocProvider(
                                                                create: (context) =>
                                                                    ProductsBloc()
                                                                      ..add(
                                                                          LoadProductsEvent()),
                                                              ),
                                                              BlocProvider(
                                                                create: (context) =>
                                                                    CartBloc()
                                                                      ..add(
                                                                          LoadCartEvent()),
                                                              )
                                                            ],
                                                            child:
                                                                const CartScreen(
                                                              title:
                                                                  "Your Cart",
                                                            ),
                                                          )),
                                                );
                                              });
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
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Total: $totalPrice",
                    style: const TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    context.goNamed("order");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black87),
                  ),
                  child: const Text('Checkout',
                      style: TextStyle(color: Colors.white)),
                )),
          );
        } else {
          return Container();
        }
        return Container();
      },
    );
  }
}
