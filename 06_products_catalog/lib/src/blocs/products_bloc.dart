import 'package:frideos_core/frideos_core.dart';

import '../models/catalog_item.dart';
import '../models/product.dart';

class ProductsBloc {
  ProductsBloc() {
    print('-------ProductsBloc BLOC--------');

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
    print('-------ProductsBloc BLOC DISPOSE--------');
    cart.dispose();

    for (var item in catalog.value) {
      item.dispose();
    }

    catalog.dispose();
  }
}
