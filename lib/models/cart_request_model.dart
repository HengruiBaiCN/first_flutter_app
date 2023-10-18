class CartRequestModel {
  late int userId;
  List<CartProducts> cartProducts = [];

  CartRequestModel({required this.userId, required this.cartProducts});

  CartRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    if (json['cart_items'] != null) {
      cartProducts = <CartProducts>[];
      json['cart_items'].forEach((v) {
        cartProducts.add(CartProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    if (cartProducts.isNotEmpty) {
      data['cart_items'] = cartProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartProducts {
  late int productId;
  late int quantity;

  CartProducts({required this.productId, required this.quantity});

  CartProducts.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}
