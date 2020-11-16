import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const DARK = Color.fromRGBO(74, 72, 73, 1);
  static const DEFAULT = Color.fromRGBO(105, 103, 105, 1);
  static const OPERATION = Color.fromRGBO(230, 148, 13, 1);

  final String text;
  final bool big;
  final Color color;
  final void Function(String) callback;

  Button({
    @required this.text,
    this.big = false,
    this.color = DEFAULT,
    @required this.callback,
  });

  Button.big({
    @required this.text,
    this.big = true,
    this.color = DEFAULT,
    @required this.callback,
  });

  Button.operation({
    @required this.text,
    this.big = false,
    this.color = OPERATION,
    @required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: big ? 2 : 1,
      child: RaisedButton(
        color: this.color,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        onPressed: () => callback(text),
      ),
    );
  }
}
