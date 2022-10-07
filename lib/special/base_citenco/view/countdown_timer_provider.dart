import 'dart:async';
import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:provider/provider.dart';
import '../util.dart';
import 'countdown_timer.dart';

class CountDownTimerProvider extends BaseProvider<CountDownTimerViewState> {
  final TimerNotifier _countDown = TimerNotifier();

  Timer? _timer;
  TimerData? _timerData;
  CountDownTimerProvider(CountDownTimerViewState state) : super(state);

  @override
  void onReady(callback) {
    super.onReady(callback);
    startCountDown();
  }

  @override
  void dispose() {
    stopCountDown();
    super.dispose();
  }

  @override
  List<BaseNotifier> initNotifiers() => [_countDown];

  TimerData? _getTimerData() {
    if (state.widget.expiredTime!.isEmpty) return null;
    DateTime? expiredTime = Utils.stringToDate(
        source: state.widget.expiredTime!, toPattern: "HH:mm:ss");
    DateTime convertExpiredTimeNow = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        expiredTime!.hour,
        expiredTime.minute,
        expiredTime.second);
    int diff = (convertExpiredTimeNow.difference(DateTime.now()).inSeconds);
    if (diff < 0) {
      return null;
    }
    int hours, min, sec = 0;
    if (diff >= 3600) {
      hours = (diff / 3600).floor();
      diff -= hours * 3600;
    } else {
      hours = 0;
    }
    if (diff >= 60) {
      min = (diff / 60).floor();
      diff -= min * 60;
    } else {
      min = 0;
    }
    sec = diff.toInt();
    return TimerData(hours: hours, min: min, sec: sec);
  }

  void startCountDown() {
    if (_timer != null) stopCountDown();
    _timerData = _getTimerData();
    _countDown.value = _timerData;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (state.mounted) {
        _timerData = _getTimerData();
        _countDown.value = _timerData;
        if (_countDown.value == null) stopCountDown();
      }
    });
  }

  void stopCountDown() {
    _timer?.cancel();
    _timer = null;
    if (state.widget.onExpired != null) {
      state.widget.onExpired!();
    }
  }

  String _getNumberAddZero(int number) {
    if (number < 10) {
      return "0" + number.toString();
    }
    return number.toString();
  }

  String getBasicCountDownWithZero(TimerData timer) {
    return _getNumberAddZero(BasePKG().intOf(() => timer.hours!)) +
        " : " +
        _getNumberAddZero(BasePKG().intOf(() => timer.min!)) +
        " : " +
        _getNumberAddZero(BasePKG().intOf(() => timer.sec!));
  }
}

class TimerNotifier extends BaseNotifier<TimerData> {
  TimerNotifier() : super(null);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<TimerNotifier>(create: (_) => this);
  }
}

class TimerData {
  final int? hours;
  final int? min;
  final int? sec;

  TimerData({this.hours, this.min, this.sec});
}
