import 'package:first_flutter_app/models/product.dart';

class CartResponseModel {
  late String status;
  late List<CartItem> data;

  CartResponseModel({required this.status, required this.data});

  CartResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CartItem>[];
      json['data'].forEach((v) {
        data.add(CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data.isNotEmpty) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItem {
  int productId = 0;
  String productName = '';
  String productRegularPrice = '';
  String productSalePrice = '';
  String thumbnail = '';
  int quantity = 0;
  double lineTotal = 0.0;
  double lineSubtotal = 0.0;

  CartItem(
      {required this.productId,
      required this.productName,
      required this.productRegularPrice,
      required this.productSalePrice,
      required this.thumbnail,
      required this.quantity,
      required this.lineTotal,
      required this.lineSubtotal,
      required Product product});

  CartItem.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productRegularPrice = json['product_regular_price'];
    productSalePrice = json['product_sale_price'];
    thumbnail = json['thumbnail'];
    quantity = json['quantity'];
    lineTotal = json['line_total'];
    lineSubtotal = json['line_subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_regular_price'] = productRegularPrice;
    data['product_sale_price'] = productSalePrice;
    data['thumbnail'] = thumbnail;
    data['quantity'] = quantity;
    data['line_total'] = lineTotal;
    data['line_subtotal'] = lineSubtotal;
    return data;
  }
}
