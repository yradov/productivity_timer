import 'package:flutter/material.dart';
import 'package:productivity_timer/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
      home: const TimerHomePage(),
    );
  }
} // MyApp

class TimerHomePage extends StatelessWidget {
  const TimerHomePage({Key? key}) : super(key: key);

  final double defaultPadding = 5;
  final double defaultMargin = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Work Timer"),
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
                    onPressed: emptyMethod,
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
                    onPressed: emptyMethod,
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
                    onPressed: emptyMethod,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
            Expanded(
              child: CircularPercentIndicator(
                radius: availableWidth / 2,
                lineWidth: 10.0,
                percent: 1,
                center:
                    const Text("30:00"),
                progressColor: const Color(0xff009688),
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
                    onPressed: emptyMethod,
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
                    onPressed: emptyMethod,
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

  void emptyMethod() {}
}// TimerHomePage
