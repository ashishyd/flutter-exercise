import 'package:flutter/material.dart';
import 'package:flutter_assignment/textControl.dart';

import 'button.dart';

void main() => runApp(FlutterAssignmentApp());

class FlutterAssignmentApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FlutterAssignmentAppState();
  }
}

class _FlutterAssignmentAppState extends State<FlutterAssignmentApp> {
  var bodyText = 'This is my first assignment';

  void _updateText() {
    setState(() {
      bodyText = 'This is my first assignment for button click';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Assigment',
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Assigment')),
        body: Column(
            children: <Widget>[TextControl(bodyText), Button(_updateText)]),
      ),
    );
  }
}
