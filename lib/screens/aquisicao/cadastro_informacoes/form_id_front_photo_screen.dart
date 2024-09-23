import 'package:flutter/material.dart';
import 'package:trigg_app/screens/aquisicao/cadastro_informacoes/form_id_front_photo_preview_screen.dart';
import 'package:trigg_app/widgets/trigg_pop_button.dart';
import 'package:trigg_app/widgets/trigg_stack_camera.dart';
import 'package:trigg_app/widgets/trigg_subtitle.dart';

class FormIdFrontPhotoScreen extends StatefulWidget {
  const FormIdFrontPhotoScreen({Key? key}) : super(key: key);
  static const routeName = "/form/id_front_photo";

  @override
  _IdFrontPhotoScreenState createState() => _IdFrontPhotoScreenState();
}

class _IdFrontPhotoScreenState extends State<FormIdFrontPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return TriggStackCamera(
      onAfterPictureTaken: () => {
        Navigator.of(context).pushNamed(FormIdFrontPhotoPreviewScreen.routeName)
      },
      overlays: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/camera_green_corners_overlay.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: height * 0.03,
          bottom: height * 0.7,
          child: Container(
            child: Column(
              children: [
                TriggSubtitle(
                  'Tire uma foto da frente',
                  size: 19,
                  textAlign: TextAlign.center,
                ),
                TriggSubtitle(
                  'do seu documento',
                  size: 19,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: width * 0.9,
          top: 0,
          bottom: height * 0.9,
          child: TriggPopButton(
            iconColor: Colors.white,
            iconSize: 40.0,
          ),
        )
      ],
    );
  }
}
