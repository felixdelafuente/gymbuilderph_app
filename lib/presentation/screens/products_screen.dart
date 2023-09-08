import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_builder_app/bloc/cart/cart_bloc.dart';
import 'package:gym_builder_app/bloc/products/products_bloc.dart';
import 'package:gym_builder_app/data/models/products_model.dart';
import 'package:gym_builder_app/presentation/screens/products_details_screen.dart';

import '../widgets/drawer.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, required this.title});
  final String title;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  // final List<ProductsModel> products = ProductsModel.getData();
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
    return BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
      if (state is ProductsLoadingState) {
        print("loading: $state");
      } else if (state is ProductsErrorState) {
        print("error: $state");
      } else if (state is ProductsLoadedState) {
        print("loaded: $state");

        List<ProductsModel> productsList = state.products;

        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => context.goNamed('menu'),
            ),
            title: Text("${widget.title} Products"),
            centerTitle: true,
            backgroundColor: const Color(0xff2b2b2b),
          ),
          drawer: appDrawer(context),
          body: Center(
              child: Container(
                  decoration: const BoxDecoration(color: Color(0xfff0f0f0)),
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    itemCount: productsList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // number of columns
                      childAspectRatio: 0.8, // aspect ratio of each item
                    ),
                    itemBuilder: (context, index) {
                      // build each item of the grid view
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                    product: productsList[index],
                                    cartBloc: cartBloc,
                                    productsBloc: _productsBloc,
                                    productsList: productsList,
                                  ),
                                )
                                // Pass the arguments as part of the RouteSettings.
                                // MaterialPageRoute(
                                //   builder: (context) => BlocProvider(
                                //       create: (context) {},
                                //       child: ProductDetailsScreen(
                                //           product: products[index])),
                                // ),
                                );
                            context.goNamed("products");
                          },
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 148,
                                  child: Image.network(
                                    "http://gymbuilderph.com${productsList[index].imageLink.toString()}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  productsList[index].name.toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  productsList[index].price.toString(),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ));
                    },
                  ))),
        );
      } else {
        return Container();
      }
      return Container();
    });
  }
}