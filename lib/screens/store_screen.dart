import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class StoreScreen extends StatelessWidget {
  static const routeName = "/store";
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RemoteConfig remoteConfig = RemoteConfig.instance;
    print(remoteConfig.getString('cartao_detalhe_id_ordem'));

    return Center(
      child: Text("Store screen"),
    );
  }
}
