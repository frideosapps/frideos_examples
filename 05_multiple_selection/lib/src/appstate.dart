import 'blocs/page_one_bloc.dart';
import 'blocs/page_two_bloc.dart';
import 'blocs/page_three_bloc.dart';

import 'package:frideos/frideos.dart';

class AppState extends AppStateModel {
  final blocA = PageOneBloc();
  final blocB = PageTwoBloc();
  final blocC = PageThreeBloc();

  AppState() {
    print('-------APPSTATE--------');

    // Senders from blocOne to blocTwo
    blocA.tunnelSenderSelectedItemsTwo
        .setReceiver(blocB.tunnelReceiverSelectedItems);

    // Senders from blocOne to blocThree
    blocA.tunnelSenderSelectedItemsThree
        .setReceiver(blocC.tunnelReceiverSelectedItems);

    // From blocTwo and Three to blocOne
    blocB.tunnelSenderMessage.setReceiver(blocA.tunnelReceiverMessage);
    blocC.tunnelSenderMessage.setReceiver(blocA.tunnelReceiverMessage);
  }

  @override
  void init() {}

  @override
  void dispose() {
    print('-------TUNNEL BLOC DISPOSE--------');

    blocA.dispose();
    blocB.dispose();
    blocC.dispose();
  }
}
