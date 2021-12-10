import 'package:flutter/material.dart';
import 'package:productivity_timer/widgets.dart';

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

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextStyle textStyle = const TextStyle(fontSize: 24);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          Text("Work", style: textStyle),
          const Text(""),
          const Text(""),
          const SettingButton(color: Color(0xff455A64), text: "-", value: -1),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          const SettingButton(color: Color(0xff009688), text: "+", value: 1),
          Text("Short", style: textStyle),
          const Text(""),
          const Text(""),
          const SettingButton(color: Color(0xff455A64), text: "-", value: -1),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          const SettingButton(color: Color(0xff009688), text: "+", value: 1),
          Text("Long", style: textStyle),
          const Text(""),
          const Text(""),
          const SettingButton(color: Color(0xff455A64), text: "-", value: -1),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          const SettingButton(color: Color(0xff009688), text: "+", value: 1),
        ],
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }
}
