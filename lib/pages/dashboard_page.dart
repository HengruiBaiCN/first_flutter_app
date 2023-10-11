// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_flutter_app/pages/product_page.dart';
import 'package:first_flutter_app/widgets/widget_home_categories.dart';
import 'package:first_flutter_app/widgets/widget_home_products.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          // padding: const EdgeInsets.symmetric(vertical: 5.0),
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF2EAEA),
              ),
              child: Text(
                'A Modern Story with Ancient Botanicals',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            imageCarousel(context),
            const SizedBox(
              height: 10,
            ),
            WidgetHomeProducts(labelName: "Top Products", tagId: "top"),
            const SizedBox(
              height: 10,
            ),
            shopCollection(context),
            const SizedBox(
              height: 10,
            ),
            WidgetCategories(),
          ],
        ),
      ),
    );
  }

  Widget imageCarousel(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF2EAEA),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200.0,
        child: CarouselSlider(
          items: [
            FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  'https://dilkara.com.au/wp-content/uploads/2023/04/image-4-1.png'),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  'https://dilkara.com.au/wp-content/uploads/2023/04/image-3-1.png'),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  'https://dilkara.com.au/wp-content/uploads/2023/04/image-2-1.png'),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  'https://dilkara.com.au/wp-content/uploads/2023/10/Screenshot-2023-10-10-at-11.55.32 am.png'),
            ),
          ],
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
        ),
      ),
    );
  }

  Widget shopCollection(BuildContext context) {
    return Container(
      height: 250,
      color: const Color(0xFFF2EAEA),
      child: Column(
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, top: 4),
                child: Text(
                  'VIEW RANGE',
                  // widget.labelName ?? 'Top Products',
                  // widget.labelName, A value of type 'Null' can't be assigned to a parameter of type 'String' in a const constructor.
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 4),
                child: Text(
                  'SHOP COLLECTION',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              // First child
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background image
                    Image.network(
                      'https://dilkara.com.au/wp-content/uploads/2023/03/dreamstime_m_109201801.jpg',
                      fit: BoxFit.cover,
                      width: 180,
                      height: 180,
                    ),
                    // Text and Button
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hair',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductPage(
                                  categoryId: 69,
                                ),
                              ),
                            );
                            // Button click action
                          },
                          child: Text('Shop now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Second child
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background image
                    Image.network(
                      'https://dilkara.com.au/wp-content/uploads/2023/03/dreamstime_m_80922926.jpg',
                      fit: BoxFit.fill,
                      width: 180,
                      height: 180,
                    ),
                    // Text and Button
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Skin',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductPage(
                                  categoryId: 70,
                                ),
                              ),
                            );
                            // Button click action
                          },
                          child: Text('Shop now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
