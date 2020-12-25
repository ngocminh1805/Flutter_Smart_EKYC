import 'dart:io';
import 'package:flutter/material.dart';

class EkycImagePreview extends StatefulWidget {
  final String path;
  EkycImagePreview({this.path});

  @override
  _EkycImagePreView createState() => _EkycImagePreView();
}

class _EkycImagePreView extends State<EkycImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(image: FileImage(File(widget.path), scale: 2.5)),
    );
  }
}
