import 'package:first_flutter_app/api_service.dart';
import 'package:first_flutter_app/models/product.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetRelatedProducts extends StatefulWidget {
  WidgetRelatedProducts({Key? key, required this.labelName, this.products})
      : super(key: key);

  final String labelName;
  List<int>? products;

  @override
  State<WidgetRelatedProducts> createState() => _WidgetRelatedProductsState();
}

class _WidgetRelatedProductsState extends State<WidgetRelatedProducts> {
  APIService apiService = APIService();
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    apiService = APIService();
    products = apiService.getProductsByTag(relatedIds: widget.products);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Text(
              widget.labelName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          _productList(),
        ],
      ),
    );
  }

  Widget _productList() {
    return FutureBuilder<List<Product>>(
      future: products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Zero Products related to this product',
              style: TextStyle(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ));
        } else {
          return _buildProductList(snapshot.data!);
        }
      },
    );
  }

  Widget _buildProductList(List<Product> products) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          var data = products[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10),
                width: 130,
                height: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 5),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Image.network(
                  data.images[0].src,
                  height: 120,
                ),
              ),
              Container(
                width: 130,
                alignment: Alignment.centerLeft,
                child: Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4, left: 4),
                width: 130,
                alignment: Alignment.centerLeft,
                child: Row(children: [
                  Text(
                    '\$${data.salePrice}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(data.regularPrice.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.lineThrough,
                      )),
                ]),
              )
            ],
          );
        },
      ),
    );
  }
}
