import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> cameras;

  // late CameraImage cameraImage;

  var cameraCount = 0;
  var isCameraInitialized = false.obs;

  var x, y, w, h = 0.0;
  var label = "";

  initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();

      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.bgra8888
      );
      await cameraController.initialize().then((value) {
        cameraController.startImageStream((image) {
          cameraCount++;
          if (cameraCount % 5 == 0) {
              cameraCount = 0;
            objectDetector(image);
          }
          update();
        });
      });
      isCameraInitialized(true);
      update();
    } else {
      print('Permission denied');
    }
  }

  initTFLite() async {
    await Tflite.loadModel(
      model: "assets/tflite/model.tflite",
      labels: "assets/tflite/labels.txt",
      isAsset: true,
      numThreads: 1,
      useGpuDelegate: false,
    );
  }

  objectDetector(CameraImage image) async {
    var detector = await Tflite.runModelOnFrame(
      bytesList: image.planes.map((e) {
        return e.bytes;
      }).toList(),
      asynch: true,
      imageHeight: image.height,
      imageWidth: image.width,
      imageMean: 127.5,
      imageStd: 127.5,
      rotation: 90,
      threshold: 0.4,
    );
    print('+++++++++++++++++++++++++++$label++++++++++++++++++++++++++++++++++++++++');
    print('+++++++++++++++++++++++++++$detector++++++++++++++++++++++++++++++++++++++++');


    if (detector != null) {
      var ourDetectedObject = detector.first;
      if(ourDetectedObject['confidenceInClass'] * 100 > 45 ){
        label = detector.first['detectedClass'].toString();
        h = ourDetectedObject['react']['h'];
        w = ourDetectedObject['react']['w'];
        x = ourDetectedObject['react']['x'];
        y = ourDetectedObject['react']['y'];
        print('+++++++++++++++++++++++++++$label++++++++++++++++++++++++++++++++++++++++');
        print('+++++++++++++++++++++++++++$detector++++++++++++++++++++++++++++++++++++++++');
      }
      update();
      print('+++++++++++++++++++++++++++$label++++++++++++++++++++++++++++++++++++++++');
      print('+++++++++++++++++++++++++++$detector++++++++++++++++++++++++++++++++++++++++');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initCamera();
    initTFLite();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController.dispose();
     Tflite.close();

  }
}
