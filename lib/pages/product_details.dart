import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/pages/base_page.dart';
import 'package:first_flutter_app/widgets/widget_product_details.dart';
import 'package:flutter/material.dart';

class ProductDetails extends BasePage {
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends BasePageState<ProductDetails> {
  // @override
  // Widget build(BuildContext context) {
  //   return ProductDetailsWidget(data: widget.product);
  // }
  @override
  Widget pageUI() {
    return ProductDetailsWidget(data: widget.product);
  }
}
