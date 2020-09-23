import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validasi_ektp/ktp_model.dart';
import 'package:validasi_ektp/validasi_form.dart';

import 'controller.dart';
import 'detail_screen.dart';

class InputScreen extends StatelessWidget {
  final Controller _controller= Get.find();
  final ControllerKTP _controllerKTP = ControllerKTP();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Validasi E-KTP"),
        ),
        body: ValidasiForm(false));
  }
}
