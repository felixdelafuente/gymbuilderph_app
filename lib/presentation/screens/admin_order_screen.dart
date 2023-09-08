import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_builder_app/bloc/order/order_bloc.dart';
import 'package:gym_builder_app/data/models/order_model.dart';

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({super.key});

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen> {
  late OrderBloc orderBloc;

  @override
  void initState() {
    orderBloc = BlocProvider.of<OrderBloc>(context);
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
        const DataColumn(label: Text('Order ID')),
        const DataColumn(label: Text('Product ID')),
        const DataColumn(label: Text('Quantity')),
        const DataColumn(label: Text('Price')),
        const DataColumn(label: Text('Total Amount')),
        const DataColumn(label: Text('User ID')),
        const DataColumn(label: Text('Order Date')),
        const DataColumn(label: Text('Delivery Status')),
      ];
    }

    // Define a function that returns a list of data rows for the table
    List<DataRow> getDataRows(List<OrderModel> orderList) {
      return orderList.map((product) {
        return DataRow(cells: [
          DataCell(Text(product.orderId.toString())),
          DataCell(Text(product.productId.toString())),
          DataCell(Text(product.quantity.toString())),
          DataCell(Text(product.price.toString())),
          DataCell(Text(product.totalAmount.toString())),
          DataCell(Text(product.userId.toString())),
          DataCell(Text(product.orderDate.toString())),
          DataCell(Text(product.deliveryStatus.toString())),
        ]);
      }).toList();
    }

    // Return a widget that displays the table in a scrollable view
    return BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
      if (state is OrderLoadingState) {
        print("loading: $state");
      } else if (state is OrderErrorState) {
        print("error: $state");
      } else if (state is OrderLoadedState) {
        print("loaded: $state");

        List<OrderModel> orderList = state.order;

        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => context.goNamed('admin-menu'),
            ),
            title: const Text("Order"),
            centerTitle: true,
            backgroundColor: const Color(0xff2b2b2b),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: getDataColumns(),
              rows: getDataRows(orderList),
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
