import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:trigg_app/devices/trigg_camera_controller.dart';

class TriggCamera extends StatefulWidget {
  final loadingWidget;
  TriggCamera({Key? key, this.loadingWidget}) : super(key: key);

  _TriggCameraState createState() => _TriggCameraState();
}

class _TriggCameraState extends State<TriggCamera> with WidgetsBindingObserver {
  void initState() {
    super.initState();
    TriggCameraController.setupCamera(update, mounted);
  }

  void update() {
    setState(() {});
  }

  @override
  void dispose() {
    TriggCameraController.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (TriggCameraController.controller == null ||
        !TriggCameraController.controller!.value.isInitialized) {
      return Container(
        child: widget.loadingWidget,
      );
    }

    return CameraPreview(TriggCameraController.controller!);
  }
}
