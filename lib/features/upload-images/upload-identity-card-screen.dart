import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_ekyc/api/base.dart';
import 'package:smart_ekyc/features/upload-images/finish-screen.dart';
import 'package:http/http.dart' as http;

class UploadIdentityCardScreen extends StatefulWidget {
  @override
  _UploadIdentityCardScreen createState() => new _UploadIdentityCardScreen();
}

class _UploadIdentityCardScreen extends State<UploadIdentityCardScreen> {
  var base = Base();
  CameraController controller;
  List cameras;
  int selectedCameraIdx; // choose front camera ar back camera
  int step = 0;
  String imagePath1;
  String imagePath2;
  String imagePath3;
  bool preview = false;
  String token;

  @override
  void initState() {
    super.initState();
    // 1
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIdx = 0;
        });

        _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      // 3
      print('Error: $err.code\nError Message: $err.message');
    });
    //
  }

// -------------------  -----------------------------------------
  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    // 4
    controller.addListener(() {
      // 5
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    // 6
    try {
      await controller.initialize();
    } on CameraException catch (e) {
      // _showCameraException(e);
      print("Camera Err: ${e}");
    }

    if (mounted) {
      setState(() {});
    }
  }

  ///-------------------------------- render main screen -----------------------------------------------
  Widget renderMainScreen() {
    if (preview && step == 0) {
      return previewImage(imagePath1);
    } else if (preview && step == 1) {
      return previewImage(imagePath2);
    } else {
      return Container(
        child: Stack(
          children: <Widget>[_cameraPreviewWidget(), _sq()],
        ),
      );
    }
  }

  //--------------------------- camera widget -------------------------------------------------
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }

  //----------------------------- render preview screen ----------------------
  Widget previewImage(String path) {
    return Container(
      child: Image(
        image: FileImage(File(path)),
      ),
    );
  }

  // -------------------------- render title ------------------------------

  String title() {
    if (!preview && step == 0) {
      return "Chụp mặt trước";
    } else if (preview && step == 0) {
      return "Xem ảnh mặt trước";
    } else if (!preview && step == 1) {
      return "Chụp mặt sau";
    } else if (preview && step == 1) {
      return "Xem ảnh mặt sau";
    } else {
      return "Chụp ảnh khuôn mặt";
    }
  }

  // ---------------- render button ctn -----------------------------
  Widget buttonConatiner() {
    if (preview) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 5, right: 20, left: 20),
              child: FlatButton(
                onPressed: () => onConfirm(),
                child: Text(
                  "Ok",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Colors.blueGrey,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8)),
              ),
            ),
            Container(
              child: FlatButton(
                onPressed: () => onReCapture(),
                child: Text(
                  "Chụp Lại",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Colors.blueGrey,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8)),
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        height: 60,
        width: 60,
        margin: EdgeInsets.only(top: 5),
        child: FlatButton(
          child: Icon(
            Icons.camera,
            color: Colors.white,
            size: 45,
          ),
          padding: EdgeInsets.all(0),
          onPressed: () => onCapturePressed(),
          color: Colors.blueGrey,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30)),
        ),
      );
    }
  }

  // ----------------------- render sq ------------------------------

  Widget _sq() {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }
    if (step < 2) {
      return Positioned.fill(
          child: Opacity(
        opacity: 0.5,
        child: Image(
          image: AssetImage('assets/sq.png'),
        ),
      ));
    } else {
      return Positioned.fill(
          child: Opacity(
        opacity: 0.5,
        child: Image(
          image: AssetImage('assets/sq2.png'),
        ),
      ));
    }
  }

  // ----------------------- build -----------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 30,
          right: 10,
          left: 10,
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                title(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: renderMainScreen(),
            ),
            buttonConatiner()
          ],
        ),
      ),
    );
  }

  // ------------------- on press capture -----------------------
  void onCapturePressed() async {
    try {
      // 1
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      // 2
      await controller.takePicture(path);
      log("PATH IMAGES : " + path);
      log("STEP :  ${step}");
      if (step == 0) {
        setState(() {
          imagePath1 = path;
          preview = true;
        });
      } else if (step == 1) {
        setState(() {
          imagePath2 = path;
          preview = true;
        });
      } else {
        ocr();
        setState(() {
          imagePath3 = path;
        });
        Navigator.push(
          this.context,
          MaterialPageRoute(
              builder: (context) => FinishScreen(
                    path1: imagePath1,
                    path2: imagePath2,
                    path3: imagePath3,
                  )),
        );
      }
    } catch (e) {
      print(e);
    }
  }

//--------------------- switch camera -----------------------------
  void onSwitchCamera() {
    selectedCameraIdx =
        selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    _initCameraController(selectedCamera);
  }

  // ---------------- comfirm  --------------------
  void onConfirm() {
    if (step == 1) {
      onSwitchCamera();
    }
    setState(() {
      preview = false;
      step++;
    });
  }

  // ---------------- reCapture --------------------
  void onReCapture() {
    setState(() {
      preview = false;
    });
  }

  // --------------- check face ---------------------
  void checkFace() {}

  // --------------- OCR ----------------------------
  Future ocr() async {
    String token;
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('Token');
    log('TOKEN_SharedPreferences : ' + token);
    // ignore: non_constant_identifier_names
    var URL = base.URL_OCR;
    var req = new http.MultipartRequest("POST", Uri.parse(URL));
    Map<String, String> headers = {"Authorization": "Bear " + token};
    // open a bytestream

    req.files.add(await http.MultipartFile.fromPath('IdCardFront', imagePath1));
    req.files.add(await http.MultipartFile.fromPath('IdCardBack', imagePath2));
    req.headers.addAll(headers);

    var res = await req.send();
    res.stream.transform(utf8.decoder).listen((response) {
      log("RESPONSE_OCR :" + response);
    });
  }
}
