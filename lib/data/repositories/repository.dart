import 'package:gym_builder_app/data/models/address_model.dart';
import 'package:gym_builder_app/data/models/cart_model.dart';
import 'package:gym_builder_app/data/models/order_model.dart';
import 'package:gym_builder_app/data/models/products_model.dart';
import 'package:gym_builder_app/data/models/user_model.dart';
import 'package:gym_builder_app/data/provider/api_provider.dart';

class Repository {
  final _provider = ApiProvider();

  // AUTHENTICATION
  Future<UserModel> loginResponse(String email, String password) {
    return _provider.loginRequest(email, password);
  }

  // PRODUCTS
  Future<List<ProductsModel>> getProducts() async {
    try {
      print("before repo try working");
      final List productsResult = await _provider.productsRequest();
      print("repo try working");
      return productsResult.map((e) => ProductsModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to load products");
    }
  }

  // CART
  Future<List<CartModel>> getCart() async {
    try {
      final List cartResult = await _provider.cartRequest();

      return cartResult.map((e) => CartModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to load cart, ${e.toString()}");
    }
  }

  Future<dynamic> addCart(
    int userId,
    int productId,
    int quantity,
  ) {
    return _provider.cartAddRequest(
      userId,
      productId,
      quantity,
    );
  }

  Future<dynamic> updateCart(
    int userId,
    int productId,
    int quantity,
  ) {
    return _provider.cartUpdateRequest(
      userId,
      productId,
      quantity,
    );
  }

  Future<dynamic> deleteCart(int orderId) {
    return _provider.cartDeleteRequest(orderId);
  }

  // ADDRESS
  Future<List<AddressModel>> getAddress() async {
    try {
      final List addressResult = await _provider.addressRequest();

      return addressResult.map((e) => AddressModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to load address, ${e.toString()}");
    }
  }

  Future<dynamic> addAddress(
    int userId,
    String addressLine1,
    String addressLine2,
    String city,
    String country,
    String postalCode,
    String phoneNumber,
  ) {
    return _provider.addressAddRequest(
      userId,
      addressLine1,
      addressLine2,
      city,
      country,
      postalCode,
      phoneNumber,
    );
  }

  Future<dynamic> updateAddress(
    int addressId,
    int userId,
    String addressLine1,
    String addressLine2,
    String city,
    String country,
    String postalCode,
    String phoneNumber,
  ) {
    return _provider.addressUpdateRequest(
      addressId,
      userId,
      addressLine1,
      addressLine2,
      city,
      country,
      postalCode,
      phoneNumber,
    );
  }

  // ORDER
  Future<List<OrderModel>> getOrder() async {
    try {
      final List cartResult = await _provider.orderRequest();

      return cartResult.map((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to load order, ${e.toString()}");
    }
  }

  Future<dynamic> addOrder(
    int userId,
    int addressId,
    String orderDate,
    double totalAmount,
    String status,
    String deliveryStatus,
    List<ProductsModel> orderItems,
  ) {
    return _provider.orderAddRequest(
      userId,
      addressId,
      orderDate,
      totalAmount,
      status,
      deliveryStatus,
      orderItems,
    );
  }

  Future deleteOrder(int? orderId) {
    return _provider.orderDeleteRequest(orderId!);
  }

  // Future<dynamic> updateProducts(
  //   int memberId,
  //   dynamic avatar,
  //   String name,
  //   String lastname,
  //   String email,
  //   String companyName,
  //   String contactNumber,
  //   String region,
  //   String province,
  //   String town,
  //   String barangay,
  //   String postalCode,
  //   String streetAddress,
  //   String landmark,
  // ) {
  //   return _provider.productsUpdateRequest(
  //     memberId,
  //     avatar,
  //     name,
  //     lastname,
  //     email,
  //     companyName,
  //     contactNumber,
  //     region,
  //     province,
  //     town,
  //     barangay,
  //     postalCode,
  //     streetAddress,
  //     landmark,
  //   );
  // }
}
