import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_flutter_app/models/cart_request_model.dart';
import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/provider/cart_provider.dart';
import 'package:first_flutter_app/provider/loader_provider.dart';
import 'package:first_flutter_app/utils/custom_stepper.dart';
import 'package:first_flutter_app/utils/expand_text.dart';
import 'package:first_flutter_app/widgets/widget_related_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductDetailsWidget extends StatelessWidget {
  ProductDetailsWidget({Key? key, required this.data}) : super(key: key);

  final Product data;

  CartProducts cartProducts = CartProducts(productId: 0, quantity: 0);
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
                    visible: false,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(color: Colors.red),
                        child: const Text(
                          'Sale',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    )), // false for now because we dont have on sale products
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      data.name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      '\$${data.price}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    data.stockStatus == 'instock' && data.quantity > 0
                        ? CustomStepper(
                            lowerLimit: 0,
                            upperLimit: data.quantity,
                            stepValue: 1,
                            iconSize: 20.0,
                            value: 0,
                            onChanged: (value) {
                              cartProducts.quantity = value;
                              // print(value);
                              // setState(() {
                              //   this.data.quantity = value;
                              // });
                            },
                          )
                        : const Text(
                            'Out of Stock',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                    TextButton(
                        onPressed: () => {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          fixedSize: const Size(150, 55),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Provider.of<LoaderProvider>(context, listen: false)
                                .setIsLoading(true);
                            var cartProvider = Provider.of<CartProvider>(
                                context,
                                listen: false);

                            cartProducts.productId = data.id;
                            cartProvider.addToCart(cartProducts, (val) {
                              print('cartprovider is ready');
                              Provider.of<LoaderProvider>(context,
                                      listen: false)
                                  .setIsLoading(false);
                              print(val);
                            });
                          },
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                ExpandText(
                  labelHeader: 'Product Details',
                  description: data.description,
                  shortDescription: data.shortDescription,
                ),
                // Text(
                //   parse(parse(data.description).body!.text)
                //       .documentElement!
                //       .text,
                //   style: const TextStyle(
                //       color: Colors.black,
                //       fontWeight: FontWeight.normal,
                //       fontSize: 16),
                // ),
                const Divider(),
                const SizedBox(
                  height: 5,
                ),
                WidgetRelatedProducts(
                  labelName: 'Related Products',
                  products: data.relatedIds,
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
