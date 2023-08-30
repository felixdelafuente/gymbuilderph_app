class ProductsModel {
  int? productId;
  String? name;
  String? description;
  String? price;
  String? imageLink;
  int? item;

  ProductsModel(
      {this.productId,
      this.name,
      this.description,
      this.price,
      this.imageLink,
      this.item});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    imageLink = json['image_link'];
    item = json['item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image_link'] = this.imageLink;
    data['item'] = this.item;
    return data;
  }
}

// class ProductsModel {
//   final String image;
//   final String name;
//   final double price;
//   final String description;
//   final String stock;

//   ProductsModel(
//       {required this.image,
//       required this.name,
//       required this.price,
//       required this.description,
//       required this.stock});

//   static List<ProductsModel> getData() {
//     return [
//       ProductsModel(
//           image: 'images/sample_product.jpg',
//           name: 'product 1',
//           price: 15000.00,
//           description: 'Lorem ipsum dolor sit amet consectetur.',
//           stock: '10'),
//       ProductsModel(
//           image: 'images/sample_product.jpg',
//           name: 'product 2',
//           price: 15000.00,
//           description: 'Lorem ipsum dolor sit amet consectetur.',
//           stock: '10'),
//       ProductsModel(
//           image: 'images/sample_product.jpg',
//           name: 'product 3',
//           price: 15000.00,
//           description: 'Lorem ipsum dolor sit amet consectetur.',
//           stock: '10'),
//       ProductsModel(
//           image: 'images/sample_product.jpg',
//           name: 'product 4',
//           price: 15000.00,
//           description: 'Lorem ipsum dolor sit amet consectetur.',
//           stock: '10'),
//       ProductsModel(
//           image: 'images/sample_product.jpg',
//           name: 'product 5',
//           price: 15000.00,
//           description: 'Lorem ipsum dolor sit amet consectetur.',
//           stock: '10'),
//       ProductsModel(
//           image: 'images/sample_product.jpg',
//           name: 'product 6',
//           price: 15000.00,
//           description: 'Lorem ipsum dolor sit amet consectetur.',
//           stock: '10'),
//       ProductsModel(
//           image: 'images/sample_product.jpg',
//           name: 'product 7',
//           price: 15000.00,
//           description: 'Lorem ipsum dolor sit amet consectetur.',
//           stock: '10'),
//       ProductsModel(
//           image: 'images/sample_product.jpg',
//           name: 'product 8',
//           price: 15000.00,
//           description: 'Lorem ipsum dolor sit amet consectetur.',
//           stock: '10'),
//       ProductsModel(
//           image: 'images/sample_product.jpg',
//           name: 'product 9',
//           price: 15000.00,
//           description: 'Lorem ipsum dolor sit amet consectetur.',
//           stock: '10'),
//       ProductsModel(
//           image: 'images/sample_product.jpg',
//           name: 'product 10',
//           price: 15000.00,
//           description: 'Lorem ipsum dolor sit amet consectetur.',
//           stock: '10'),
//     ];
//   }
// }
