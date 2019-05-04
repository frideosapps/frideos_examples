import 'package:frideos_core/frideos_core.dart';

import '../blocs/bloc.dart';

const products = {
  112: Product(name: 'Phone', price: 230.59),
  19: Product(name: 'Shirt', price: 30.49),
  812: Product(name: 'Guitar', price: 800.69),
  139: Product(name: 'Headphones', price: 200.99),
  12: Product(name: 'Shoes', price: 90.89),
  136: Product(name: 'PC', price: 786.99),
  101: Product(name: 'Apple', price: 0.99)
};

class Product {
  const Product({this.name, this.price});
  final String name;
  final double price;
}

class CatalogItem {
  CatalogItem({this.id});

  int id;
  final quantity = StreamedValue<int>();
  final totalPrice = StreamedValue<double>();
  final added = StreamedValue<bool>(initialData: false);

  set productQuantity(int amount) {
    totalPrice.value = products[id].price * amount;
    quantity.value = amount;
  }

  int get productPrice => quantity.value;

  void refreshTotal() {
    totalPrice.value = products[id].price * quantity.value;
  }
}

class CartItem {
  CartItem({this.id});
  int id;
  int amount;
  double totalPrice;
}

class CartBloc extends BlocBase {
  CartBloc() {
    print('-------Cart BLOC--------');

    for (var id in products.keys) {
      catalog.addElement(CatalogItem(id: id));
    }
  }

  final catalog = StreamedList<CatalogItem>(initialData: []);

  final cart = StreamedList<int>(initialData: []);
  double total = 0;

  void calcTotal() {
    for (var id in cart.value) {
      total += getItem(id).totalPrice.value;
    }
  }

  void addItem(int id) {
    if (!cart.value.any((item) => item == id)) {
      
      // Add the item to the cart
      cart.addElement(id);
      getItem(id).refreshTotal();

      final item = catalog.value.firstWhere((item) => item.id == id);

      // To disable the add button
      item.added.value = true;
    } else {
      print('already in the cart');
    }
  }

  void removeItem(int id) {
    if (cart.value.any((item) => item == id)) {      
      cart.value.removeWhere((item) => item == id);
      catalog.value.firstWhere((item) => item.id == id).added.value = false;
      cart.refresh();
    } else {
      print('Not in the cart');
    }
  }

  void changeQuantity(int id, String value) {
    final qnt = int.tryParse(value);
    final item = catalog.value.firstWhere((item) => item.id == id);

    if (qnt != null && qnt > 0) {
      item.quantity.value = int.tryParse(value);
      item.refreshTotal();
    } else {
      item.quantity.stream.addError('Insert a valid quantity.');
    }
  }

  CatalogItem getItem(int id) {
    return catalog.value.firstWhere((item) => item.id == id);
  }

  @override
  void dispose() {
    print('-------Cart BLOC DISPOSE--------');
  }
}
