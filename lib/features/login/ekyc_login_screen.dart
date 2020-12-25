import 'package:flutter/material.dart';
import 'package:smart_ekyc/features/login/components/ekyc_form-input.dart';

class EkycLoginScreen extends StatefulWidget {
  @override
  _EkycLoginScreenState createState() => new _EkycLoginScreenState();
}

class _EkycLoginScreenState extends State<EkycLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return new Future(() => false);
        },
        child: Scaffold(
          body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 70),
            child: Column(
              children: <Widget>[
                // --------------- logo ---------------------
                Image(image: AssetImage('lib/assets/hyper-logo.png')),

                //--------------- Form input  ---------------------
                EkycFormInput(),

                // ------------ bottom text -------------------------
                Text(
                  "Copyright © 2020 Smart eKYC. Designed by Hyperlogy.",
                  style: TextStyle(color: Colors.blueGrey),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ));
  }
}
