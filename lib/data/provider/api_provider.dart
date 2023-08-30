import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym_builder_app/data/models/products_model.dart';
import 'package:gym_builder_app/data/models/user_model.dart';
import 'package:gym_builder_app/main.dart';

class ApiProvider {
  final Dio _dio = Dio(BaseOptions(
    // baseUrl: 'http://localhost/gymbuilderph_api/',
    baseUrl:
        'http://192.168.1.3/gymbuilderph_api/', // Modify IP address base on location
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 30),
  ));

  // AUTHENTICATION
  Future<UserModel> loginRequest(String email, String password) async {
    UserModel? loginRequest;
    try {
      Response response = await _dio.post(
        'login.php',
        data: {
          'email': email,
          'password': password,
        },
      );
      debugPrint("response data${response.data.toString()}");
      loginState.login(response.data);
      loginRequest = UserModel();
      debugPrint("loginrequest ${loginRequest.toString()}");

      // Save User ID upon Login
      // Storage localStorage = window.localStorage;
      // localStorage["cebuanaUserId"] = response.data['result']['id'].toString();
    } on DioException catch (e) {
      if (e.response != null) {
        // ErrorResponse(message: e.response?.data['message']);
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data['message']}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
    }
    return loginRequest!;
  }

  // PRODUCTS
  Future<List<dynamic>> productsRequest() async {
    List<dynamic> productsResult;
    try {
      print("before response working");
      Response response = await _dio.get('view_products.php');
      // print(response); // api response
      debugPrint("response working");
      debugPrint(response.data.runtimeType.toString());
      productsResult = response.data;

      // print(productsResult);
      debugPrint("productsResult working");
      return productsResult;
    } on DioException catch (e) {
      debugPrint("productsRequest not working 1");
      if (e.response != null) {
        debugPrint("productsRequest not working 2");
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data['message']}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        debugPrint("productsRequest not working 3");
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // CART
  Future<List<dynamic>> cartRequest() async {
    List<dynamic> cartResult;
    print(loginState.user!.userId);
    try {
      Response response =
          await _dio.get('get_cart.php?user_id=${loginState.user!.userId}');
      cartResult = response.data;
      print("cartResult: $cartResult");
      return cartResult;
    } on DioException catch (e) {
      print("cartRequest not working 1");
      if (e.response != null) {
        print("cartRequest not working 2");
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data['message']}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        print("cartRequest not working 3");
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> cartAddRequest(
    int userId,
    int productId,
    int quantity,
  ) async {
    dynamic cartAddRequest;
    try {
      Response response = await _dio.post('add_cart.php', data: {
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
      });
      cartAddRequest = response.data;
      print("try add works");
    } on DioException catch (e) {
      if (e.response != null) {
        cartAddRequest = e.response?.data['message'];
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data['message']}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        cartAddRequest = "Something went wrong";
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
    }
    return cartUpdateRequest;
  }

  Future<dynamic> cartUpdateRequest(
    int userId,
    int productId,
    int quantity,
  ) async {
    dynamic cartUpdateRequest;
    try {
      Response response =
          await _dio.put('edit_cart.php?user_id=$userId', data: {
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
      });
      cartUpdateRequest = response.data;
      print("try update works");
    } on DioException catch (e) {
      if (e.response != null) {
        cartUpdateRequest = e.response?.data['message'];
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data['message']}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        cartUpdateRequest = "Something went wrong";
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
    }
    return cartUpdateRequest!;
  }

  Future<dynamic> cartDeleteRequest(int cartId) async {
    dynamic cartDeleteRequest;
    try {
      Response response = await _dio.delete('empty_cart.php?cart_id=$cartId');
      cartDeleteRequest = response.data;
      print("try delete works");
    } on DioException catch (e) {
      if (e.response != null) {
        cartDeleteRequest = e.response?.data['message'];
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data['message']}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        cartDeleteRequest = "Something went wrong";
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
    }
    return cartDeleteRequest!;
  }

  // ADDRESS
  Future<List<dynamic>> addressRequest() async {
    List<dynamic> addressResult;
    print("user id: ${loginState.user!.userId}");
    try {
      print("!!!! before response works");
      Response response =
          await _dio.get('address.php?user_id=${loginState.user!.userId}');
      addressResult = response.data;
      print("addressResult: $addressResult");
      return addressResult;
    } on DioException catch (e) {
      print("addressResult not working 1");
      if (e.response != null) {
        print("addressResult not working 2");
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data['message']}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        print("addressResult not working 3");
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addressAddRequest(
    int userId,
    String addressLine1,
    String addressLine2,
    String city,
    String country,
    String postalCode,
    String phoneNumber,
  ) async {
    dynamic addressAddRequest;
    try {
      Response response = await _dio.post('address.php', data: {
        "user_id": userId,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "city": city,
        "country": country,
        "postal_code": postalCode,
        "phone_number": phoneNumber,
      });
      addressAddRequest = response.data;
      print("try add address works");
    } on DioException catch (e) {
      if (e.response != null) {
        addressAddRequest = e.response?.data['message'];
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data['message']}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        addressAddRequest = "Something went wrong";
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
    }
    return addressAddRequest;
  }

  Future<dynamic> addressUpdateRequest(
    int addressId,
    int userId,
    String addressLine1,
    String addressLine2,
    String city,
    String country,
    String postalCode,
    String phoneNumber,
  ) async {
    dynamic addressUpdateRequest;
    try {
      Response response =
          await _dio.put('address.php?address_id=$addressId', data: {
        "user_id": userId,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "city": city,
        "country": country,
        "postal_code": postalCode,
        "phone_number": phoneNumber,
      });
      addressUpdateRequest = response.data;
      print("try add address works");
    } on DioException catch (e) {
      if (e.response != null) {
        addressUpdateRequest = e.response?.data['message'];
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data['message']}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        addressUpdateRequest = "Something went wrong";
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
    }
    return addressUpdateRequest;
  }

  // ORDER
  // Future<List<dynamic>> orderRequest() async {
  //   List<dynamic> orderResult;
  //   print(loginState.user!.userId);
  //   try {
  //     Response response =
  //         await _dio.get('get_cart.php?user_id=${loginState.user!.userId}');
  //     orderResult = response.data;
  //     print("cartResult: $orderResult");
  //     return orderResult;
  //   } on DioException catch (e) {
  //     print("cartRequest not working 1");
  //     if (e.response != null) {
  //       print("cartRequest not working 2");
  //       debugPrint('Dio error!');
  //       debugPrint('STATUS: ${e.response?.statusCode}');
  //       debugPrint('DATA: ${e.response?.data['message']}');
  //       debugPrint('HEADERS: ${e.response?.headers}');
  //     } else {
  //       print("cartRequest not working 3");
  //       debugPrint('Error sending request!');
  //       debugPrint(e.message);
  //     }
  //     rethrow;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  
  Future<dynamic> orderAddRequest(
    int userId,
    int addressId,
    String orderDate,
    double totalAmount,
    String status,
    String deliveryStatus,
    List<ProductsModel> orderItems,
  ) async {
    dynamic orderAddRequest;
    try {
      // Create an empty list to store the orderitems map
      List<Map<String, dynamic>> orderitems = [];

      // Loop through the orderItems list and add each product's id, quantity and price to the orderitems list as a map
      for (ProductsModel product in orderItems) {
        orderitems.add({
          "product_id": product.productId,
          "quantity": product.item,
          "price": double.parse(product.price.toString()) *
              int.parse(product.item.toString()),
        });
      }

      print("try add order outside works");
      // Use the orderitems list as the value for the "orderitems" key in the data map
      Response response = await _dio.post('create_order.php', data: {
        "user_id": userId,
        "address_id": addressId,
        "order_date": orderDate,
        "total_amount": totalAmount,
        "status": status,
        "delivery_status": deliveryStatus,
        "orderitems": orderitems
      });
      orderAddRequest = response.data;
      print("try add order inside works");
    } on DioException catch (e) {
      if (e.response != null) {
        orderAddRequest = e.response?.data['message'];
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data['message']}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        orderAddRequest = "Something went wrong";
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
    }
    return orderAddRequest;
  }
}
