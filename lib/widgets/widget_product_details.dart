import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_flutter_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailsWidget extends StatelessWidget {
  ProductDetailsWidget({Key? key, required this.data}) : super(key: key);

  final Product data;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                productImages(data.images, context),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Colors.red),
                        child: Text(
                          'Sale',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    ),
                    visible:
                        false), // false for now because we dont have on sale products
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget productImages(List<ProductImages> images, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) {
                  return Center(
                    child: Image.network(
                      images[index].src,
                      fit: BoxFit.fill,
                    ),
                  );
                },
                options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    aspectRatio: 1.0),
                carouselController: _controller),
          ),
          Positioned(
            top: 100,
            // left: MediaQuery.of(context).size.width / 2 - 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                _controller.previousPage();
              },
            ),
          ),
          Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width - 80,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                _controller.nextPage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
