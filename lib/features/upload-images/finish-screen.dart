import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_ekyc/features/upload-images/components/image-preview.dart';
import 'package:smart_ekyc/features/upload-images/components/user-info-item.dart';

class FinishScreen extends StatefulWidget {
  final String path1;
  final String path2;
  final String path3;

  FinishScreen({this.path1, this.path2, this.path3});

  @override
  _FinishSceen createState() => _FinishSceen();
}

class _FinishSceen extends State<FinishScreen> {
  List data = [];

  @override
  void initState() {
    data.add(UserInfo('Loại thẻ', 'GIẤY CHỨNG MINH NHÂN DÂN'));
    data.add(UserInfo('Chứng minh nhân dân số', '174635352'));
    data.add(UserInfo('Họ và tên', 'NGUYỄN NGỌC MINH'));
    data.add(UserInfo('Ngày,tháng,năm,sinh', '18/05/1999'));
    data.add(UserInfo('Quê quán', 'xã Đại Lộc, Hậu Lộc, Thanh Hóa'));
    data.add(UserInfo('Địa chỉ thường chú', 'xã Đại Lộc, Hậu Lộc, Thanh Hóa'));
    data.add(UserInfo('Giới tính', ''));
    data.add(UserInfo('Ngày cấp', '06/11/2015'));
    data.add(UserInfo('Có giá trị đến', ''));
    data.add(UserInfo('Dân tộc/Quốc tịch', 'Kinh'));
    data.add(widget.path1);
    data.add(widget.path2);

    log('size of data: ${data.length}');
    super.initState();
  }

  Widget items(item) {
    if (item.runtimeType == UserInfo) {
      return UserInfoItem(label: item.label, value: item.value);
    } else {
      return ImagePreview(path: item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 40, bottom: 10),
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: CircleAvatar(
                    backgroundImage: FileImage(File(widget.path3)),
                    radius: 75,
                  ),
                ),
                Text(
                  "mặt chụp và CMT trùng nhau",
                  style: TextStyle(color: Colors.green),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(right: 20, left: 20),
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
            // color: Colors.blueGrey,
            child: FlatButton(
              onPressed: () => onReCapture(),
              child: Text(
                "Chụp lại khuôn mặt",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              color: Colors.blueGrey,
              padding: EdgeInsets.only(bottom: 5, top: 5, left: 30, right: 30),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return items(data[index]);
              },
              itemCount: data.length,
            ),
          ),
        ],
      )),
    );
  }

  // list view

  void onReCapture() {
    Navigator.pop(context);
  }
}

class UserInfo {
  String label;
  String value;

  UserInfo(this.label, this.value);
}
