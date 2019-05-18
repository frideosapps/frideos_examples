import 'package:frideos_core/frideos_core.dart';

import 'package:frideos/frideos.dart';

class StagedPageTwoBloc {
  StagedPageTwoBloc() {
    print('-------StagedPageTwo BLOC--------');
    receiverWidget.outStream.listen((map) {
      staged.setStagesMap(map);
    });
  }

  final receiverWidget = StreamedMap<int, Stage>(initialData: {});
  final receiverStr = StreamedValue<String>();

  // Create an instance with the setStagesMap constructor
  // or use the default constractor and the setStagesMap method
  final staged = StagedObject();

  final scrollingText = StreamedValue<String>();

  final timerObject = TimerObject();

  @override
  void dispose() {
    print('-------StagedPageTwo BLOC DISPOSE--------');
    timerObject.dispose();
    staged.dispose();
    receiverWidget.dispose();
    receiverStr.dispose();
    scrollingText.dispose();
  }
}
