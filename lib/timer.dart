import 'dart:async';
import './timermodel.dart';

class CountDownTimer {
  double _radius = 1;
  bool _isActive = true;
  Timer? timer;
  Duration? _time;
  Duration? _fullTime;
  int work = 30;

  int shortBreack = 5;
  int longBreack = 20;

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int a) {
      String time;
      if (_isActive) {
        _time = _time! - const Duration(seconds: 1);
        _radius = _time!.inSeconds / _fullTime!.inSeconds;
        if (_time!.inSeconds <= 0) {
          _isActive = false;
        }
      }
      time = returnTime(_time!);
      return TimerModel(time, _radius);
    });
  }

  String returnTime(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? "0" + t.inMinutes.toString()
        : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds =
        (numSeconds < 10) ? '0' + numSeconds.toString() : numSeconds.toString();
    String formattedTime = minutes + ":" + seconds;
    return formattedTime;
  }

  void startWork() {
    _radius = 1;
    _time = Duration(minutes: work, seconds: 0);
    _fullTime = _time;
  }

  void stopTimer() {
    _isActive = false;
  }

  void startTimer() {
    if (_time!.inSeconds > 0) {
      _isActive = true;
    }
  }

  void startBreack({required bool isShort}) {
    _radius = 1;
    _time = Duration(minutes: isShort ? shortBreack : longBreack, seconds: 0);
    _fullTime = _time;
  }
}// CountDownTimer
