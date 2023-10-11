// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:first_flutter_app/api_service.dart';
import 'package:first_flutter_app/models/category.dart';
import 'package:first_flutter_app/pages/product_page.dart';
import 'package:flutter/material.dart';

class WidgetCategories extends StatefulWidget {
  const WidgetCategories({Key? key}) : super(key: key);

  @override
  State<WidgetCategories> createState() => _WidgetCategoriesState();
}

class _WidgetCategoriesState extends State<WidgetCategories> {
  APIService apiService = APIService();
  late Future<List> categories;

  @override
  void initState() {
    super.initState();
    apiService = APIService();
    categories = apiService.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
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
                  style: TextStyle(fontSize: 20, color: Colors.black),
                )),
          ],
        ),
        _categoryList()
      ]),
    );
  }

  Widget _categoryList() {
    // print('entering category list');
    return FutureBuilder<dynamic>(
      future: categories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data found');
        } else {
          return _buildCategoryList(snapshot.data);
        }
      },
    );
  }

  Widget _buildCategoryList(List<Category> categories) {
    return Container(
      height: 130,
      alignment: Alignment.center,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          var data = categories[index];
          return GestureDetector(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductPage(categoryId: data.categoryId)))
              // Navigator.pushNamed(context, '/category',
              //     arguments: {'id': data.categoryId, 'name': data.categoryName})
            },
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
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
                  child: Text(data.categoryName.toString()),
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
            ),
          );
        },
      ),
    );
  }
}
