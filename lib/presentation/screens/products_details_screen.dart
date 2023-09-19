import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_builder_app/bloc/cart/cart_bloc.dart';
import 'package:gym_builder_app/bloc/products/products_bloc.dart';
import 'package:gym_builder_app/data/models/cart_model.dart';
import 'package:gym_builder_app/data/models/products_model.dart';
import 'package:gym_builder_app/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductsModel product;
  final CartBloc cartBloc;
  final ProductsBloc productsBloc;
  final List<ProductsModel> productsList;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
    required this.cartBloc,
    required this.productsBloc,
    required this.productsList,
  }) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 0; // the quantity of the product to be added to the cart

  // late CartBloc cartBloc;

  @override
  void initState() {
    // cartBloc = BlocProvider.of<CartBloc>(context);
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
        List<ProductsModel> productsList = widget.productsList;

        List<CartModel> cartList = state.cart;

        // Create a set of product_ids from the cartList
        Set<String?> productIdsInCart =
            cartList.map((cart) => cart.productId.toString()).toSet();

        // Filter the productsList using the where method
        List<ProductsModel> filteredProducts = productsList.where((product) {
          // Return true if the product_id is in the set
          return productIdsInCart.contains(product.productId);
        }).toList();

        print("filtered products: $filteredProducts");

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.product.name.toString()),
            centerTitle: true,
            backgroundColor: const Color(0xff2b2b2b),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // display the product image
                FittedBox(
                  // width: 300,
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    "http://gymbuilderph.com${widget.product.imageLink}",
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                const SizedBox(height: 16),
                // display the product name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.product.name.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // display the product price
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "₱${widget.product.price}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // display the product description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.product.description.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // display the quantity counter and add to cart button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // quantity counter
                    Row(
                      children: [
                        // minus button
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (quantity > 0) {
                                quantity--;
                              }
                            });
                          },
                          icon: const Icon(Icons.remove),
                          color: Colors.black,
                        ),
                        // quantity display
                        Text(
                          "$quantity",
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                        ),
                        // plus button
                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          icon: const Icon(Icons.add),
                          color: Colors.black,
                        ),
                      ],
                    ),
                    // add to cart button
                    ElevatedButton.icon(
                      onPressed: () {
                        // for (ProductsModel product in filteredProducts) {
                        //   if (int.parse(product.productId.toString()) ==
                        //       int.parse(widget.product.productId.toString())) {
                        //     cartId = product.
                        //     quantity += int.parse(product.item.toString());
                        //   } else {
                        //     widget.cartBloc.add(AddCartEvent(
                        //         userId: int.parse(
                        //             loginState.user.userId.toString()),
                        //         productId: int.parse(
                        //             widget.product.productId.toString()),
                        //         quantity: quantity));
                        //   }
                        // }

                        widget.cartBloc.add(AddCartEvent(
                            userId:
                                int.parse(loginState.user!.userId.toString()),
                            productId:
                                int.parse(widget.product.productId.toString()),
                            quantity: quantity));

                        // Call the showToast method with the message and other parameters
                        Fluttertoast.showToast(
                          msg: 'Added to cart successfully!',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        // add the product and quantity to the cart bloc
                        // cartBloc.add(AddToCartEvent(widget.product, quantity));
                      },
                      icon:
                          const Icon(Icons.shopping_cart, color: Colors.white),
                      label: const Text("Add to Cart",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      } else {
        return Container();
      }
      return Container();
    });
  }
}
