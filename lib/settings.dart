import 'package:flutter/material.dart';
import 'package:productivity_timer/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        child: Settings(),
      ),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  static const String WORK_TIME = "workTime";
  static const String SHORT_BREACK = "shortBreack";
  static const String LONG_BREACK = "longBreack";

  static const int DEFAULT_WORK_TIME = 30;
  static const int DEFAULT_SHORT_BREACK = 5;
  static const int DEFAULT_LONG_BREACK = 20;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextStyle textStyle = const TextStyle(fontSize: 24);

  static const int MIN_TIME = 1;
  static const int MAX_WORK_TIME = 180;
  static const int MAX_SHORT_BREACK = 120;
  static const int MAX_LONG_BREACK = 180;

  late int workTime;
  late int shortBreack;
  late int longBreack;

  static late SharedPreferences prefs;

  TextEditingController txtWork = TextEditingController();
  TextEditingController txtShort = TextEditingController();
  TextEditingController txtLong = TextEditingController();

  @override
  void initState() {
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 3,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: <Widget>[
        Text("Work", style: textStyle),
        const Text(""),
        const Text(""),
        SettingButton(
            setting: Settings.WORK_TIME,
            color: const Color(0xff455A64),
            text: "-",
            value: -1,
            callback: updateSettings),
        TextField(
          controller: txtWork,
          style: textStyle,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
        ),
        SettingButton(
            setting: Settings.WORK_TIME,
            color: const Color(0xff009688),
            text: "+",
            value: 1,
            callback: updateSettings),
        Text("Short", style: textStyle),
        const Text(""),
        const Text(""),
        SettingButton(
            setting: Settings.SHORT_BREACK,
            color: const Color(0xff455A64),
            text: "-",
            value: -1,
            callback: updateSettings),
        TextField(
          controller: txtShort,
          style: textStyle,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
        ),
        SettingButton(
            setting: Settings.SHORT_BREACK,
            color: const Color(0xff009688),
            text: "+",
            value: 1,
            callback: updateSettings),
        Text("Long", style: textStyle),
        const Text(""),
        const Text(""),
        SettingButton(
            setting: Settings.LONG_BREACK,
            color: const Color(0xff455A64),
            text: "-",
            value: -1,
            callback: updateSettings),
        TextField(
          controller: txtLong,
          style: textStyle,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
        ),
        SettingButton(
            setting: Settings.LONG_BREACK,
            color: const Color(0xff009688),
            text: "+",
            value: 1,
            callback: updateSettings),
        const Text(""),
        const Text(""),
        const Text(""),
        const Text(""),
        SettingButton(
            setting: '',
            color: const Color(0xFF550000),
            text: "Set Defaults",
            value: 0,
            callback: setDefaultSettings),
        const Text(""),
      ],
      padding: const EdgeInsets.all(20.0),
    );
  } // build

  void readSettings() async {
    prefs = await SharedPreferences.getInstance();
    workTime = prefs.getInt(Settings.WORK_TIME) ?? Settings.DEFAULT_WORK_TIME;
    shortBreack =
        prefs.getInt(Settings.SHORT_BREACK) ?? Settings.DEFAULT_SHORT_BREACK;
    longBreack =
        prefs.getInt(Settings.LONG_BREACK) ?? Settings.DEFAULT_LONG_BREACK;

    updateState();
  } // readSettings

  void updateSettings(String key, int value) {
    bool changed = false;

    switch (key) {
      case Settings.WORK_TIME:
        workTime =
            prefs.getInt(Settings.WORK_TIME) ?? Settings.DEFAULT_WORK_TIME;
        workTime += value;
        if (workTime >= MIN_TIME && workTime <= MAX_WORK_TIME) {
          prefs.setInt(Settings.WORK_TIME, workTime);
          changed = true;
        }
        break;
      case Settings.SHORT_BREACK:
        shortBreack = prefs.getInt(Settings.SHORT_BREACK) ??
            Settings.DEFAULT_SHORT_BREACK;
        shortBreack += value;
        if (shortBreack >= MIN_TIME && shortBreack <= MAX_SHORT_BREACK) {
          prefs.setInt(Settings.SHORT_BREACK, shortBreack);
          changed = true;
        }
        break;
      case Settings.LONG_BREACK:
        longBreack =
            prefs.getInt(Settings.LONG_BREACK) ?? Settings.DEFAULT_LONG_BREACK;
        longBreack += value;
        if (longBreack >= MIN_TIME && longBreack <= MAX_LONG_BREACK) {
          prefs.setInt(Settings.LONG_BREACK, longBreack);
          changed = true;
        }
        break;
    }

    if (changed) {
      updateState();
      changed = false;
    }
  } // updateSettings

  void updateState() {
    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreack.toString();
      txtLong.text = longBreack.toString();
    });
  }

  void setDefaultSettings(String key, int value) {
    workTime = Settings.DEFAULT_WORK_TIME;
    shortBreack = Settings.DEFAULT_SHORT_BREACK;
    longBreack = Settings.DEFAULT_LONG_BREACK;

    prefs.setInt(Settings.WORK_TIME, workTime);
    prefs.setInt(Settings.SHORT_BREACK, shortBreack);
    prefs.setInt(Settings.LONG_BREACK, longBreack);
    
    updateState();
  } //setDefaultSettings
}// _SettingsState
