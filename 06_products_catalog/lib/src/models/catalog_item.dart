import 'package:frideos_core/frideos_core.dart';

import '../models/product.dart';

class CatalogItem {
  CatalogItem({this.id}) {
    quantity =
        StreamedValue<int>(onError: (e) => print('Validation error: $e'));
  }

  int id;
  StreamedValue<int> quantity;
  final totalPrice = StreamedValue<double>();
  final added = StreamedValue<bool>(initialData: false);

  int get productPrice => quantity.value;

  void refreshTotal() {
    totalPrice.value = products[id].price * quantity.value;
  }

  void dispose() {
    quantity.dispose();
    totalPrice.dispose();
    added.dispose();
  }
}
