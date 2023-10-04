// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_flutter_app/widgets/widget_home_categories.dart';
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
          children: [
            imageCarousel(context),
            WidgetCategories(),
            // WidgetHomeProducts(labelName: "Top Products", tagId: "top"),
          ],
        ),
      ),
    );
  }

  Widget imageCarousel(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      child: CarouselSlider(
        // TODO: we need to add images here
        items: [
          Text(
            'upload some product images or logo here',
            textAlign: TextAlign.center,
            textScaleFactor: 1.5,
          )
        ],
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
      ),
    );
  }
}
