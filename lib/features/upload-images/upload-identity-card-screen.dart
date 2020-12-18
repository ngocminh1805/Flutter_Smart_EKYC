import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:smart_ekyc/features/upload-images/components/cameraWidget.dart';
import 'package:smart_ekyc/features/upload-images/finish-screen.dart';

class UploadIdentityCardScreen extends StatefulWidget {
  @override
  _UploadIdentityCardScreen createState() => new _UploadIdentityCardScreen();
}

class _UploadIdentityCardScreen extends State<UploadIdentityCardScreen> {
  CameraController controller;
  List cameras;
  int selectedCameraIdx;
  String imagePath;

  @override
  void initState() {
    super.initState();
    // 1
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.length > 0) {
        setState(() {
          // 2
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
  }

// -------------------  -----------------------------------------
  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    // 3
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

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
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
                "Chụp mặt trước",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: _cameraPreviewWidget(),
            ),
            Container(
              height: 60,
              width: 60,
              margin: EdgeInsets.only(top: 5),
              child: FlatButton(
                child: Icon(
                  Icons.camera,
                  color: Colors.white,
                  size: 50,
                ),
                padding: EdgeInsets.all(0),
                onPressed: () => onCapturePressed(),
                color: Colors.blueGrey,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30)),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///
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
      complete();
    } catch (e) {
      print(e);
    }
  }

  //
  void complete() {
    Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => FinishScreen()),
    );
  }
}
