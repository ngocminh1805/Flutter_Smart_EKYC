import 'package:flutter/material.dart';
import 'package:smart_ekyc/features/login/components/form-input.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 100),
        child: Column(
          children: <Widget>[
            // --------------- logo ---------------------
            Image(image: AssetImage('assets/hyper-logo.png')),

            //--------------- Form input  ---------------------
            FormInput(),

            Text(
              "Copyright © 2020 Smart eKYC. Designed by Hyperlogy.",
              style: TextStyle(color: Colors.blueGrey),
            )
          ],
        ),
      ),
    );
  }
}
