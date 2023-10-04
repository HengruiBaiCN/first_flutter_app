import 'package:first_flutter_app/models/product.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  ProductCard({Key? key, required this.data}) : super(key: key);

  Product data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0XFFFFFFFF),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 10,
            blurRadius: 15,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                    child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 120,
                      backgroundColor: Color.fromARGB(255, 103, 193, 207),
                    ),
                    Image.network(
                      data.images!.isNotEmpty
                          ? data.images![0].src
                          : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                      height: 160,
                    )
                  ],
                )),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    data.name,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$${data.price}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '\$${data.salePrice}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
