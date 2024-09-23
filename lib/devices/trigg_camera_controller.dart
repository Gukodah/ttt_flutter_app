import 'package:camera/camera.dart';

class TriggCameraController {
  static List<CameraDescription>? cameras;
  static CameraController? controller;
  static String? lastTakenPicturePath;

  static void takePicture(Function? onAfterPictureTaken) async {
    try {
      controller!.takePicture().then(
            (XFile? photo) => {
              lastTakenPicturePath = photo!.path,
              onAfterPictureTaken!(),
            },
          );
    } catch (e) {
      print(e);
    }
  }

  static void setupCamera(
    Function updateDependentWidget,
    bool isDependentWidgetMounted,
  ) async {
    cameras = await availableCameras();
    controller = CameraController(cameras![0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!isDependentWidgetMounted) {
        return;
      }
      updateDependentWidget();
    });
  }
}
