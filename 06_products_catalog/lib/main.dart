import 'package:flutter/material.dart';

import 'src/screens/products_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Products catalog",
      theme: ThemeData.light(),
      home: ProductsPage(),
    );
  }
}
