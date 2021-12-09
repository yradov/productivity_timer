import 'package:flutter/material.dart';
import 'package:productivity_timer/settings.dart';
import 'package:productivity_timer/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './timer.dart';
import './timermodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: TimerHomePage(),
    );
  }
} // MyApp

class TimerHomePage extends StatelessWidget {
  TimerHomePage({Key? key}) : super(key: key);

  final List<PopupMenuItem<String>> menuItems = <PopupMenuItem<String>>[
    const PopupMenuItem<String>(
      value: 'Home',
      child: Text('Home'),
    ),
    const PopupMenuItem<String>(
      value: 'Settings',
      child: Text('Settings'),
    ),
  ];

  void goToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  final double defaultPadding = 5;
  final double defaultMargin = 10;
  final CountDownTimer timer = CountDownTimer();
  @override
  Widget build(BuildContext context) {
    timer.startWork();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Work Timer"),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return menuItems.toList();
            },
            onSelected: (s) {
              if (s == 'Settings') {
                goToSettings(context);
              }
            },
          ),
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final double availableWidth = constraints.maxWidth;
        return Column(
          children: [
            SizedBox(
              height: defaultMargin,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    color: const Color(0xff009688),
                    text: 'Work',
                    size: 150,
                    onPressed: () => timer.startWork(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    color: const Color(0xff607D8B),
                    text: 'Short Break',
                    size: 150,
                    onPressed: () => timer.startBreack(isShort: true),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    color: const Color(0xff455A64),
                    text: 'Long Break',
                    size: 150,
                    onPressed: () => timer.startBreack(isShort: false),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                initialData: '00:00',
                stream: timer.stream(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  TimerModel timer = (snapshot.data == '00:00')
                      ? TimerModel('00:00', 1)
                      : snapshot.data;
                  return CircularPercentIndicator(
                    radius: availableWidth / 2,
                    lineWidth: 10.0,
                    percent: timer.percent,
                    center: Text(
                      timer.time,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    progressColor: const Color(0xff009688),
                  );
                },
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    color: const Color(0xff212121),
                    text: 'Stop',
                    size: 150,
                    onPressed: () => timer.stopTimer(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    color: const Color(0xff009688),
                    text: 'Restart',
                    size: 150,
                    onPressed: () => timer.startTimer(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
            SizedBox(
              height: defaultMargin,
            ),
          ],
        );
      }),
    );
  }

  // used to as stub in onPressed
  void emptyMethod() {}
}// TimerHomePage
