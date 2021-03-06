import 'package:frideos/frideos.dart';

import '../models/item.dart';

class PageTwoBloc {
  final items = StreamedList<Item>(initialData: []);
  final tunnelReceiverSelectedItems = StreamedList<Item>(initialData: []);

  // SENDERS
  final tunnelSenderMessage = StreamedSender<String>();
  send(int numItems) {
    print('SENDING SELECTED ITEMS');

    tunnelSenderMessage
        .send('Page two received $numItems item${numItems > 1 ? 's' : ''}');
  }

  PageTwoBloc() {
    print('-------PAGE TWO BLOC--------');

    tunnelReceiverSelectedItems.outStream.listen((selectedItems) {
      print('LISTEN SELECTED ITEMS');
      print('length: ${selectedItems.length}');
      items.value.addAll(selectedItems);
      send(selectedItems.length);
      items.refresh();
    });
  }

  dispose() {
    print('-------PAGE TWO BLOC DISPOSE--------');

    tunnelReceiverSelectedItems.dispose();

    items.dispose();
  }
}
