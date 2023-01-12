import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final String bodyText;

  TextControl(this.bodyText);
  
  @override
  Widget build(BuildContext context) {
    return Text(
            bodyText,
            textAlign: TextAlign.center,
          );
  }
}