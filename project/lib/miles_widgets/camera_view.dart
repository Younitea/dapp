import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

late List<CameraDescription> _cameras;

Future<void> initializeCameras() async {
  _cameras = await availableCameras();
}

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController controller;
  String? savedImageFile;

  @override
  void initState() {
    super.initState();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
        body: Column(children: [
      Expanded(
          child: Container(
              width: double.infinity,
              height: double.infinity,
              child: CameraPreview(controller))),
      Row(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
            child: Container(
          height: 256.0,
          decoration: const BoxDecoration(color: Colors.black),
          child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(24.0),
                      shape: const CircleBorder()),
                  onPressed: () async {
                    var pic = await controller.takePicture();

                    setState(() {
                      savedImageFile = pic.path;
                    });
                  },
                  child: const Icon(Icons.camera))),
        ))
      ]),
    ]));
  }
}
