import 'package:first_flutter_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  ProductCard({Key? key, this.data}) : super(key: key);

  Product? data;

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
        child: const Stack(
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
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.red,
                    ),
                    // Image.network(
                    //   data!.images![0].length > 0
                    //       ? data!.images![0].src
                    //       : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                    //   height: 160,
                    // ) //TODO: add image here
                  ],
                )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Error', //TODO: add product name here
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$0.00', //TODO: add product regular price here
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '\$0.00', //TODO: add product sale price here
                      style: TextStyle(
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
