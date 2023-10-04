import 'package:first_flutter_app/api_service.dart';
import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/pages/base_page.dart';
import 'package:first_flutter_app/widgets/widget_product_card.dart';
import 'package:flutter/material.dart';

class SortBy {
  String value;
  String text;
  String sortOrder;

  SortBy({required this.value, required this.text, required this.sortOrder});
}

// ignore: must_be_immutable
class ProductPage extends BasePage {
  ProductPage({Key? key, required this.categoryId}) : super(key: key);

  int categoryId;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends BasePageState<ProductPage> {
  APIService apiService = APIService();
  late Future<List<Product>> products;
  final _sortByOptions = [
    SortBy(value: 'popularity', text: 'Popularity', sortOrder: "asc"),
    SortBy(value: 'modified', text: 'Latest', sortOrder: "asc"),
    SortBy(value: 'price', text: 'Price: low to high', sortOrder: "asc"),
    SortBy(value: 'price', text: 'Price: high to low', sortOrder: "desc"),
  ];

  @override
  void initState() {
    super.initState();
    apiService = APIService();
    products = apiService.getProductsByTag(categoryId: widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return _productList();
  }

  @override
  Widget pageUI() {
    return _productList();
  }

  Widget _productList() {
    return FutureBuilder(
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
          print(widget.categoryId);
          return const Center(child: Text('No products found'));
        } else {
          return _buildProductList(snapshot.data!);
        }
      },
    );
  }

  Widget _buildProductList(List<Product> items) {
    return Column(
      children: [
        _productFilters(),
        Flexible(
            child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: items.map((Product item) {
            return ProductCard(data: item);
          }).toList(),
        ))
      ],
    );
  }

  Widget _productFilters() {
    return Container(
      height: 51,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Row(
        children: [
          const Flexible(
              child: Material(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  borderSide: BorderSide.none,
                ),
                fillColor: Color(0xffe6e6ec),
                filled: true,
              ),
            ),
          )),
          const SizedBox(
            width: 15,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffe6e6ec),
              borderRadius: BorderRadius.all(Radius.circular(9.0)),
            ),
            child: PopupMenuButton(
              onSelected: (sortBy) {
                setState(() {
                  products = apiService.getProductsByTag(
                    sortBy: sortBy.value,
                    sortOrder: sortBy.sortOrder,
                  );
                });
              },
              itemBuilder: (BuildContext context) {
                return _sortByOptions.map((option) {
                  return PopupMenuItem(
                    value: option,
                    child: Container(
                      child: Text(option.text),
                    ),
                  );
                }).toList();
              },
              icon: const Icon(Icons.tune),
            ),
          ),
        ],
      ),
    );
  }
}
