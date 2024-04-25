import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:muzey_app/src/features/camera/controller/scan_controller.dart';
import 'package:muzey_app/src/widgets/custom_search_input_widget.dart';

import '../../../theme/constants/app_colors.dart';

class CameraScreen extends StatefulWidget {
  static const route = r'/camera';

  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Camera Screen'),),
      body: GetBuilder<ScanController>(
          init: ScanController(),
          builder: (controller) {
            return controller.isCameraInitialized.value ? Stack(
              children: [
                CameraPreview(controller.cameraController),
                Positioned(
                  // top: (controller.y) * 700,
                  // right: (controller.x) * 500,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          color: AppColors.white,
                          child: Text(controller.label,style:TextStyle(
                            color: AppColors.purpleAccent
                          ),
                          )),
                    ],
                  ),
                )
              ],
            ): Text('Try again again');
          }),
    );
  }
}
