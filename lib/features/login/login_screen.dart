import 'dart:developer';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameContoller = TextEditingController();
  final passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 100),
        child: Column(
          children: <Widget>[
            // --------------- logo ---------------------
            Image(image: AssetImage('assets/hyper-logo.png')),
            //--------------- Title ---------------------
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "NHẬP THÔNG TIN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            //---------------- input user name ----------------
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: 'nhập tên đăng nhập',
                  labelText: "Tên đăng nhập",
                ),
                controller: userNameContoller,
              ),
            ),
            // ------------------ input password ----------------------
            Padding(
              padding:
                  EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 40),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'nhập mật khẩu',
                    labelText: "Mật khẩu"),
                controller: passWordController,
                obscureText: true,
              ),
            ),

            // ---------------- submit button ------------------------------
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(right: 20, left: 20),
              child: FlatButton(
                  onPressed: () => onSubmit(),
                  child: Text(
                    "Đăng nhập",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blueGrey,
                  padding:
                      EdgeInsets.only(bottom: 5, top: 5, left: 30, right: 30),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30))),
            )
          ],
        ),
      ),
    );
  }

  // --------------- on submit press ----------------------------------
  void onSubmit() {
    var userName = userNameContoller.text;
    var passWord = passWordController.text;

    log("User Info :" + userName + " - " + passWord);
  }
}
