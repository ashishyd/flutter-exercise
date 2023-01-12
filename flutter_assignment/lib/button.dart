import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function updateTextHandler;

  Button(this.updateTextHandler);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Change Text'),
      onPressed: updateTextHandler,
    );
  }
}
