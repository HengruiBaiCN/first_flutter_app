import 'package:first_flutter_app/api_service.dart';
import 'package:first_flutter_app/models/cart_request_model.dart';
import 'package:first_flutter_app/models/cart_response_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  APIService apiService = APIService();
  List<CartItem> _items = [];

  List<CartItem> get cartItems => _items;
  double get totalRecord => _items.length.toDouble();

  CartProvider() {
    apiService = APIService();
    _items = [];
  }

  void resetStreams() {
    _items = [];
    apiService = APIService();
  }

  void addToCart(CartProducts product, Function callback) async {
    CartRequestModel requestModel =
        CartRequestModel(userId: 1, cartProducts: []);

    if (_items.isEmpty) resetStreams();

    for (var element in _items) {
      requestModel.cartProducts.add(CartProducts(
          productId: element.productId, quantity: element.quantity));
    }

    var isProductExist = requestModel.cartProducts
        .where((element) => element.productId == product.productId);

    if (isProductExist.isEmpty) {
      requestModel.cartProducts
          .add(CartProducts(productId: product.productId, quantity: 1));
    } else {
      for (var element in requestModel.cartProducts) {
        if (element.productId == product.productId) {
          element.quantity++;
        }
      }
    }

    print(
        'requestModel.cartProducts isEmpty is: ${requestModel.cartProducts.isEmpty}');

    await apiService.addToCart(requestModel).then((cartResponseModel) {
      if (cartResponseModel?.status == 'success' &&
          cartResponseModel!.data.isNotEmpty) {
        _items = cartResponseModel.data;
      } else {
        callback(cartResponseModel);
        notifyListeners();
      }
    });
  }
}
