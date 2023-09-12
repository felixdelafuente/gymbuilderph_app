import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_builder_app/bloc/order/order_bloc.dart';
import 'package:gym_builder_app/bloc/products/products_bloc.dart';
import 'package:gym_builder_app/data/models/order_item_model.dart';
import 'package:gym_builder_app/data/models/products_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  late OrderBloc orderBloc;
  late ProductsBloc productsBloc;
  double totalSales = 0;
  int mostPopularProductId = 0;
  int mostPopularProductQuantity = 0;

  @override
  void initState() {
    orderBloc = BlocProvider.of<OrderBloc>(context);
    productsBloc = BlocProvider.of<ProductsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
      if (state is OrderLoadingState) {
        print("loading: $state");
      } else if (state is OrderErrorState) {
        print("error: $state");
      } else if (state is AllOrderLoadedState) {
        print("loaded: $state");

        List<OrderItemModel> orderList = state.order;

        return dashboardItems(context, orderList);
      } else {
        return Container();
      }
      return Container();
    });
  }

  Widget dashboardItems(BuildContext _, List<OrderItemModel> orderList) {
    return BlocBuilder<ProductsBloc, ProductsState>(
        builder: (_, productsState) {
      if (productsState is ProductsLoadingState) {
        print("loading: $productsState");
      } else if (productsState is ProductsErrorState) {
        print("error: $productsState");
      } else if (productsState is ProductsLoadedState) {
        // print("loaded: $productsState");

        List<ProductsModel> productsList = productsState.products;

        // Create an empty map to store the grouped items
        Map<int, double> groupedItems = {};

// Loop through the orderList and update the map
        for (var item in orderList) {
          // Get the product_id and price of the current item
          int productId = int.parse(item.productId.toString());
          double price = double.parse(item.price.toString());

          // If the map already contains the product_id, add the price to the existing value
          // Otherwise, set the value to the price
          if (groupedItems.containsKey(productId)) {
            groupedItems[productId] = groupedItems[productId]! + price;
          } else {
            groupedItems[productId] = price;
          }
        }

// Convert the map to a list of OrderItemModel
        List<OrderItemModel> newList = groupedItems.entries
            .map((entry) => OrderItemModel(
                productId: entry.key, price: entry.value.toString()))
            .toList();

        // Calculate the total sales by adding all the price values
        totalSales = orderList.fold(
            0, (sum, order) => sum + double.parse(order.price.toString()));
        // Find the product id that has the highest occurrence among the list
        Map<int, int> productCount = {};
        for (OrderItemModel order in orderList) {
          productCount[int.parse(order.productId.toString())] =
              (productCount[order.productId] ?? 0) +
                  int.parse(order.quantity.toString());
        }
        mostPopularProductId = productCount.keys.first;
        mostPopularProductQuantity = productCount.values.first;
        for (int key in productCount.keys) {
          if (productCount[key]! > mostPopularProductQuantity) {
            mostPopularProductId = key;
            mostPopularProductQuantity = productCount[key]!;
          }
        }

        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => _.pushNamed("menu"),
            ),
            title: const Text("Dashboard"),
            centerTitle: true,
            backgroundColor: const Color(0xff2b2b2b),
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Total Sales: ₱${totalSales.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Most Popular Product: ${productsList.firstWhere(
                                (p) => p.productId == mostPopularProductId,
                              ).name}\n'
                          'Total Quantity Sold: $mostPopularProductQuantity',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    Card(
                        child: Container(
                          height: 500,
                      padding: const EdgeInsets.all(8.0),
                      child: SfCircularChart(
                        title: ChartTitle(text: "Product Sales"),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        legend: Legend(
                            position: LegendPosition.bottom,
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap),
                        series: _getElevationDoughnutSeries(
                                orderItem: newList, productsList: productsList)
                            .toList(),
                      ),
                    )),
                  ],
                ),
              )),
        );
      } else {
        return Container();
      }
      return Container();
    });
  }

  List<DoughnutSeries<_ChartData, String>> _getElevationDoughnutSeries(
      {required List orderItem, required List<ProductsModel> productsList}) {
    int colorIndex = 0; // initialize counter variable
    final Iterable<_ChartData> chartData = orderItem.map((data) {
      Random random = Random();
      return _ChartData(
          x: productsList
              .firstWhere(
                (p) => p.productId.toString() == data.productId.toString(),
              )
              .name,
          y: int.parse(double.parse(data.price.toString()).round().toString()),
          pointColor:
              Colors.primaries[random.nextInt(Colors.primaries.length)]);
    });

    // return chartData;
    return <DoughnutSeries<_ChartData, String>>[
      DoughnutSeries<_ChartData, String>(
          enableTooltip: true,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          dataSource: chartData.toList(),
          innerRadius: '30',
          animationDuration: 0,
          xValueMapper: (_ChartData data, _) => data.x as String,
          yValueMapper: (_ChartData data, _) => data.y,
          pointColorMapper: (_ChartData data, _) => data.pointColor)
    ];
  }
}

class _ChartData {
  _ChartData({this.x, this.y, this.pointColor});
  final String? x;
  final int? y;
  final Color? pointColor;
}
