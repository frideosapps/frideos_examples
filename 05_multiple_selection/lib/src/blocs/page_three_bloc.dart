import 'package:frideos_core/frideos_core.dart';

import '../models/border_item.dart';
import '../models/item.dart';

class PageThreeBloc {
  final items = StreamedList<Item>(initialData: []);
  final tunnelReceiverSelectedItems = StreamedList<Item>(initialData: []);

  // SENDERS
  final tunnelSenderMessage = StreamedSender<String>();
  send(int numItems) {
    print('SENDING SELECTED ITEMS');

    tunnelSenderMessage
        .send('Page three received $numItems item${numItems > 1 ? 's' : ''}');
  }

  PageThreeBloc() {
    print('-------PAGE THREE BLOC--------');

    tunnelReceiverSelectedItems.outStream.listen((selectedItems) {
      print('length: ${selectedItems.length}');
      items.value.addAll(selectedItems);
      send(selectedItems.length);
      items.refresh();
    });
  }

  dispose() {
    print('-------PAGE THREE BLOC DISPOSE--------');

    tunnelReceiverSelectedItems.dispose();

    items.dispose();
  }
}
