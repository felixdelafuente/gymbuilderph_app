import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_builder_app/bloc/products/products_bloc.dart';
import 'package:gym_builder_app/data/models/products_model.dart';

class AdminProductsScreen extends StatefulWidget {
  const AdminProductsScreen({super.key});

  @override
  State<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends State<AdminProductsScreen> {
  late ProductsBloc productsBloc;

  @override
  void initState() {
    productsBloc = BlocProvider.of<ProductsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // Get the device size and orientation from MediaQuery
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    // Define a function that returns a widget for displaying an image from a link
    Widget imageFromLink(String link) {
      return Image.network(
        link,
        fit: BoxFit.cover,
        width: orientation == Orientation.portrait
            ? size.width * 0.15
            : size.width * 0.1,
        height: orientation == Orientation.portrait
            ? size.height * 0.1
            : size.height * 0.15,
      );
    }

    // Define a function that returns a list of data columns for the table
    List<DataColumn> getDataColumns() {
      return [
        const DataColumn(label: Text('ID')),
        const DataColumn(label: Text('Name')),
        const DataColumn(label: Text('Description')),
        const DataColumn(label: Text('Price')),
        const DataColumn(label: Text('Image Link')),
        const DataColumn(label: Text('Quantity')),
      ];
    }

    // Define a function that returns a list of data rows for the table
    List<DataRow> getDataRows(List<ProductsModel> productsList) {
      return productsList.map((product) {
        return DataRow(cells: [
          DataCell(Text(product.productId.toString())),
          DataCell(Text(product.name.toString())),
          DataCell(Text(product.description.toString())),
          DataCell(Text(product.price.toString())),
          DataCell(
            SizedBox(
              height: 50,
              child: Image.network(
                "http://gymbuilderph.com${product.imageLink.toString()}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          DataCell(Text(product.item.toString())),
        ]);
      }).toList();
    }

    // Return a widget that displays the table in a scrollable view
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
              onPressed: () => context.goNamed('admin-menu'),
            ),
            title: const Text("Products"),
            centerTitle: true,
            backgroundColor: const Color(0xff2b2b2b),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: getDataColumns(),
              rows: getDataRows(productsList),
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
