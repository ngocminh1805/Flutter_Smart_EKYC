import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget {
  @override
  _CameraWidget createState() => _CameraWidget();
}

class _CameraWidget extends State<CameraWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Camera View"),
        decoration: BoxDecoration(color: Colors.amberAccent),
      ),
    );
  }
}
