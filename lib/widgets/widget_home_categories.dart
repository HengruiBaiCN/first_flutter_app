// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:first_flutter_app/api_service.dart';
import 'package:first_flutter_app/models/category.dart';
import 'package:flutter/material.dart';

class WidgetCategories extends StatefulWidget {
  const WidgetCategories({Key? key}) : super(key: key);

  @override
  State<WidgetCategories> createState() => _WidgetCategoriesState();
}

class _WidgetCategoriesState extends State<WidgetCategories> {
  APIService apiService = APIService();

  @override
  void initState() {
    super.initState();
    apiService = APIService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 10, top: 4),
                child: Text(
                  'All Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: EdgeInsets.only(left: 10, top: 4),
                child: Text(
                  'View All',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                )),
          ],
        ),
        _categoryList()
      ]),
    );
  }

  // Future<List<Map<String, dynamic>>> fetchAndParseCategories() async {
  //   final response = await WooCommerceService().fetchCategories();

  //   // List<Category> data = [];

  //   if (response is Map<String, dynamic>) {
  //     // Handle the map structure here and extract the list of products
  //     // data.addAll(response);
  //     print('response has categories ${response}');
  //     final categoryList = response as List<dynamic>;
  //     return categoryList.cast<Map<String, dynamic>>().toList();
  //   } else {
  //     // Handle the case where the response is not as expected
  //     print('response does not have categories');
  //     throw Exception('Unexpected API response format');
  //   }
  // }

  Widget _categoryList() {
    // print('entering category list');
    return FutureBuilder<dynamic>(
      future: apiService.getCategories(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return _buildCategoryList(snapshot.data);
        } else if (snapshot.data == null) {
          return const Text('No data found');
        } else if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data);
          return const Text('No data');
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildCategoryList(List<Category> categories) {
    return Container(
      height: 150,
      alignment: Alignment.center,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          var data = categories[index];
          return Column(
            children: [
              Container(
                height: 100,
                width: 100,
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(data.categoryName.toString()),
                // child: Image.network(
                //   data.categoryImage.toString(),
                //   height: 80,
                // ),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 5),
                      blurRadius: 15,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(data.categoryName.toString()),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    size: 14,
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
