import 'package:frideos_core/frideos_core.dart';

import '../blocs/bloc_base.dart';

class TimerObjectBloc extends BlocBase {
  TimerObjectBloc() {
    print('-------TimerObject BLOC--------');
  }

  final timerObject = TimerObject();

  void startTimer() {
    timerObject.startTimer();
  }

  void stopTimer() {
    timerObject.stopTimer();
  }

  void getLapTime() {
    timerObject.getLapTime();
  }

  @override
  void dispose() {
    print('-------TimerObject BLOC DISPOSE--------');

    timerObject.dispose();
  }
}
