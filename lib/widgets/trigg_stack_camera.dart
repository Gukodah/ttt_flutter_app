import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:trigg_app/widgets/trigg_camera.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trigg_app/devices/trigg_camera_controller.dart';

class TriggStackCamera extends StatefulWidget {
  final List<Widget>? overlays;
  final Widget? customButtom;
  final Function? onAfterPictureTaken;

  TriggStackCamera(
      {Key? key, this.overlays, this.customButtom, this.onAfterPictureTaken})
      : super(key: key);

  @override
  _TriggStackCameraState createState() => _TriggStackCameraState();
}

class _TriggStackCameraState extends State<TriggStackCamera> {
  late CameraController controller;
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    void takePicture() {
      TriggCameraController.takePicture(widget.onAfterPictureTaken!);
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          TriggCamera(
            loadingWidget: SpinKitRotatingCircle(
              color: Colors.white,
              size: 50.0,
            ),
          ),
          ...?widget.overlays
        ],
      ),
      floatingActionButton: widget.customButtom != null
          ? widget.customButtom
          : Align(
              child: Padding(
                padding:
                    EdgeInsets.only(left: width * 0.07, top: height * 0.85),
                child: FloatingActionButton(
                  onPressed: takePicture,
                  elevation: 0,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
    );
  }
}
