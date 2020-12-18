import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smart_ekyc/features/upload-images/components/user-info-item.dart';

class FinishScreen extends StatefulWidget {
  @override
  _FinishSceen createState() => _FinishSceen();
}

class _FinishSceen extends State<FinishScreen> {
  List<UserInfo> data = [];

  @override
  void initState() {
    // TODO: implement initState
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

    log('size of data: ${data.length}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 40),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/image.png'),
                    radius: 75,
                  ),
                ),
                Text("mặt chụp và CMT không trùng nhau")
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(right: 20, left: 20),
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
                return UserInfoItem(
                    label: data[index].label, value: data[index].value);
                // return UserInfoItem(label: 'Label', value: 'MINH BE TI');
              },
              itemCount: data.length,
            ),
          )
          // Container(child: BodyList())
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
