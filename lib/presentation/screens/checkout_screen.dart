import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_builder_app/bloc/address/address_bloc.dart';
import 'package:gym_builder_app/bloc/cart/cart_bloc.dart';
import 'package:gym_builder_app/bloc/order/order_bloc.dart';
import 'package:gym_builder_app/bloc/products/products_bloc.dart';
import 'package:gym_builder_app/data/models/address_model.dart';
import 'package:gym_builder_app/data/models/cart_model.dart';
import 'package:gym_builder_app/data/models/products_model.dart';
import 'package:gym_builder_app/main.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.title});
  final String title;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreen();
}

class _CheckoutScreen extends State<CheckoutScreen> {
  late CartBloc cartBloc;
  late ProductsBloc productsBloc;
  late AddressBloc addressBloc;
  late OrderBloc orderBloc;
  final _formKey = GlobalKey<FormState>();
  bool _cashOnDelivery = true;

  TextEditingController addressLine1 = TextEditingController();
  TextEditingController addressLine2 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  @override
  void initState() {
    // Use the context of this widget to access the CartBloc instance
    cartBloc = BlocProvider.of<CartBloc>(context);
    productsBloc = BlocProvider.of<ProductsBloc>(context);
    addressBloc = BlocProvider.of<AddressBloc>(context);
    orderBloc = BlocProvider.of<OrderBloc>(context);
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

          return BlocBuilder<AddressBloc, AddressState>(
              builder: (addressContext, addressState) {
            if (addressState is AddressLoadingState) {
              print("loading: $addressState");
            } else if (addressState is AddressErrorState) {
              print("error: $addressState");
            } else if (addressState is AddressLoadedState) {
              print("loaded: $addressState");

              List<AddressModel> addressList = addressState.address;

              addressLine1.text = addressList.first.addressLine1 ?? "";
              addressLine2.text = addressList.first.addressLine2 ?? "";
              city.text = addressList.first.city ?? "";
              country.text = addressList.first.country ?? "";
              postalCode.text = addressList.first.postalCode ?? "";
              phoneNumber.text = addressList.first.phoneNumber ?? "";

              return Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    onPressed: () => context.pushNamed("menu"),
                  ),
                  title: const Text("Place Order"),
                  centerTitle: true,
                  backgroundColor: const Color(0xff2b2b2b),
                ),
                body: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
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
                                      double.parse(
                                          cartList[index].quantity.toString());
                              return ListTile(
                                leading: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      "http://gymbuilderph.com${item.imageLink.toString()}",
                                      height: 40,
                                      errorBuilder: (_, error, stackTrace) {
                                        return const Icon(
                                            Icons.shopping_bag_outlined);
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
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        // addressForm(_, addressLine1, addressLine2, city, country,
                        //     postalCode, phoneNumber),
                        Form(
                          key: _formKey,
                          // child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "Address",
                                style: TextStyle(fontSize: 20),
                              ),
                              TextFormField(
                                controller: addressLine1,
                                decoration: const InputDecoration(
                                  labelText: 'Address Line 1',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your address line 1';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: addressLine2,
                                decoration: const InputDecoration(
                                  labelText: 'Address Line 2',
                                ),
                              ),
                              TextFormField(
                                controller: city,
                                decoration: const InputDecoration(
                                  labelText: 'City',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your city';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: country,
                                decoration: const InputDecoration(
                                  labelText: 'Country',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your country';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: postalCode,
                                decoration: const InputDecoration(
                                  labelText: 'Postal Code',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your postal code';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: phoneNumber,
                                decoration: const InputDecoration(
                                  labelText: 'Phone Number',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  return null;
                                },
                              ),
                              Row(
                                children: <Widget>[
                                  Radio(
                                    groupValue: _cashOnDelivery,
                                    value: _cashOnDelivery,
                                    onChanged: (value) {
                                      setState(() {
                                        _cashOnDelivery = value!;
                                      });
                                    },
                                  ),
                                  const Text('Cash on Delivery'),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Submit the form data
                                    if (addressList.first.addressId
                                                .toString() !=
                                            null ||
                                        addressList.first.addressId
                                                .toString() !=
                                            "") {
                                      AddressBloc().add(UpdateAddressEvent(
                                          addressId: int.parse(addressList
                                              .first.addressId
                                              .toString()),
                                          userId: int.parse(loginState
                                              .user!.userId
                                              .toString()),
                                          addressLine1: addressLine1.text,
                                          addressLine2: addressLine2.text,
                                          city: city.text,
                                          country: country.text,
                                          postalCode: postalCode.text,
                                          phoneNumber: phoneNumber.text));
                                    } else {
                                      AddressBloc().add(AddAddressEvent(
                                          userId: int.parse(loginState
                                              .user!.userId
                                              .toString()),
                                          addressLine1: addressLine1.text,
                                          addressLine2: addressLine2.text,
                                          city: city.text,
                                          country: country.text,
                                          postalCode: postalCode.text,
                                          phoneNumber: phoneNumber.text));
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Address saved.')),
                                    );

                                    Future.delayed(const Duration(seconds: 1),
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
                                                    ),
                                                    BlocProvider(
                                                      create: (context) =>
                                                          AddressBloc()
                                                            ..add(
                                                                LoadAddressEvent()),
                                                    )
                                                  ],
                                                  child: const CheckoutScreen(
                                                    title: "Place Order",
                                                  ),
                                                )),
                                      );
                                    });
                                  }
                                },
                                child: const Text('Save Address'),
                              ),
                            ],
                          ),
                          // )
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Total: $totalPrice",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    )),
                bottomNavigationBar: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        OrderBloc().add(AddOrderEvent(
                            userId:
                                int.parse(loginState.user!.userId.toString()),
                            addressId: int.parse(addressList.first.addressId.toString()),
                            orderDate: DateTime.now().toString(),
                            totalAmount: totalPrice,
                            status: "0",
                            deliveryStatus: "processing",
                            orderItems: filteredProducts));
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black87),
                      ),
                      child: const Text('Checkout',
                          style: TextStyle(color: Colors.white)),
                    )),
              );
            } else {
              return Container();
            }
            return Container();
          });
        } else {
          return Container();
        }
        return Container();
      },
    );
  }

  // Widget addressForm(
  //     BuildContext _,
  //     TextEditingController addressLine1,
  //     TextEditingController addressLine2,
  //     TextEditingController city,
  //     TextEditingController country,
  //     TextEditingController postalCode,
  //     TextEditingController phoneNumber) {
  //   return BlocBuilder<AddressBloc, AddressState>(
  //       builder: (addressContext, addressState) {
  //     if (addressState is AddressLoadingState) {
  //       print("loading: $addressState");
  //     } else if (addressState is AddressErrorState) {
  //       print("error: $addressState");
  //     } else if (addressState is AddressLoadedState) {
  //       print("loaded: $addressState");

  //       List<AddressModel> addressList = addressState.address;

  //       addressLine1.text = addressList.first.addressLine1 ?? "";
  //       addressLine2.text = addressList.first.addressLine2 ?? "";
  //       city.text = addressList.first.city ?? "";
  //       country.text = addressList.first.country ?? "";
  //       postalCode.text = addressList.first.postalCode ?? "";
  //       phoneNumber.text = addressList.first.phoneNumber ?? "";

  //       return Expanded(
  //           child: Form(
  //         key: _formKey,
  //         // child: SingleChildScrollView(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             const Text(
  //               "Address",
  //               style: TextStyle(fontSize: 20),
  //             ),
  //             TextFormField(
  //               decoration: const InputDecoration(
  //                 labelText: 'Address Line 1',
  //               ),
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your address line 1';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             TextFormField(
  //               decoration: const InputDecoration(
  //                 labelText: 'Address Line 2',
  //               ),
  //             ),
  //             TextFormField(
  //               decoration: const InputDecoration(
  //                 labelText: 'City',
  //               ),
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your city';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             TextFormField(
  //               decoration: const InputDecoration(
  //                 labelText: 'Country',
  //               ),
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your country';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             TextFormField(
  //               decoration: const InputDecoration(
  //                 labelText: 'Postal Code',
  //               ),
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your postal code';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             TextFormField(
  //               decoration: const InputDecoration(
  //                 labelText: 'Phone Number',
  //               ),
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your phone number';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             Row(
  //               children: <Widget>[
  //                 Radio(
  //                   groupValue: _cashOnDelivery,
  //                   value: _cashOnDelivery,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       _cashOnDelivery = value!;
  //                     });
  //                   },
  //                 ),
  //                 const Text('Cash on Delivery'),
  //               ],
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 if (_formKey.currentState!.validate()) {
  //                   // Submit the form data
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                     const SnackBar(content: Text('Processing Data')),
  //                   );
  //                 }
  //               },
  //               child: const Text('Save Address'),
  //             ),
  //           ],
  //         ),
  //         // )
  //       ));
  //     } else {
  //       return Container();
  //     }
  //     return Container();
  //   });
  // }
}
