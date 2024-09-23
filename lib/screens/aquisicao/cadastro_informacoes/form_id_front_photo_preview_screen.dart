import 'dart:io';
import 'package:trigg_app/devices/trigg_camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:trigg_app/widgets/trigg_fullscreen_image.dart';
import 'package:trigg_app/widgets/trigg_subtitle.dart';

class FormIdFrontPhotoPreviewScreen extends StatelessWidget {
  static const routeName = "/form/id_front_photo_preview";

  const FormIdFrontPhotoPreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          TriggFullScreenImage(
            imageSource: Image.file(
              File(TriggCameraController.lastTakenPicturePath!),
            ).image,
          ),
          Column(
            children: [
              SizedBox(
                height: height * 0.75,
              ),
              Positioned(
                child: Container(
                  color: Color.fromRGBO(0, 0, 0, 0.8),
                  width: width,
                  height: 64,
                  child: TriggSubtitle.verticallyCentered(
                    'A foto ficou nítida?',
                    size: 18.0,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.08,
                  ),
                  SizedBox(
                    width: width * 0.4,
                    child: OutlinedButton(
                      onPressed: () => {},
                      child: Text("Não, tirar outra"),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  SizedBox(
                    width: width * 0.4,
                    child: ElevatedButton(
                      onPressed: () => {},
                      child: Text("Sim, enviar foto"),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.08,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
