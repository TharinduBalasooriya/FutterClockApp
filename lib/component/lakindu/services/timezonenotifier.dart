import 'package:clock_app/component/lakindu/services/worldtimeapi.dart';
import 'package:state_notifier/state_notifier.dart';

class TimezoneNotifier extends StateNotifier<List<String>> {
  TimezoneNotifier() : super([]) {
    _init();
  }

  _init() async {
    state = await WorldTime.getTimeZones() ?? [];
  }


}