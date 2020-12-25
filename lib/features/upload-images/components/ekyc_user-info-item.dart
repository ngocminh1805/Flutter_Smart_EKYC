import 'package:flutter/material.dart';

class EkycUserInfoItem extends StatefulWidget {
  final String label;
  final String value;

  EkycUserInfoItem({this.label, this.value});

  @override
  _EkycUserInfoItem createState() => _EkycUserInfoItem();
}

class _EkycUserInfoItem extends State<EkycUserInfoItem> {
  String label;
  String value;
  final valueController = new TextEditingController();

  @override
  void initState() {
    valueController.text = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.label ?? 'null',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 35,
              child: TextField(
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                scrollPadding:
                    EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                controller: valueController,
              ),
            )
          ],
        ));
  }
}
