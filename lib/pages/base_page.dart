import 'package:first_flutter_app/utils/progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_flutter_app/provider/loader_provider.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  bool isAPICallProcess = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(
      builder: (context, loaderProvider, child) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: ProgressHud(
            opacity: 0.3,
            inAsyncCall: loaderProvider.isLoading,
            child: pageUI(),
          ),
        );
      },
    );

    // Scaffold(
    //   appBar: _buildAppBar(),
    //   body: ProgressHud(inAsyncCall: isAPICallProcess, child: pageUI()),
    // );
  }

  Widget pageUI() {
    return const Placeholder();
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: const Color.fromARGB(255, 0, 221, 255),
      automaticallyImplyLeading: true,
      title: const Text(
        "Dilkara",
        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
