import 'package:first_flutter_app/utils/ProgressHUD.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  bool isAPICallProcess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ProgressHUD(inAsyncCall: isAPICallProcess, child: pageUI()),
    );
  }

  Widget pageUI() {
    return const Placeholder();
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: true,
      title: const Text(
        "Dilkara",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {},
        ),
      ],
    );
  }
}
