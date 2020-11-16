import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calculator/models/memory.dart';

import '../components/display.dart';
import '../components/keyboard.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final Memory memory = Memory();

  _onPressed(String command) {
    setState(() {
      memory.applyCommand(command);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      home: Column(
        children: memory.getMemoryBufferText() != ''
            ? <Widget>[
                Display.buffer(text: memory.getMemoryBufferText()),
                Display(text: memory.value),
                Keyboard(_onPressed),
              ]
            : <Widget>[
                Display(text: memory.value),
                Keyboard(_onPressed),
              ],
      ),
    );
  }
}
