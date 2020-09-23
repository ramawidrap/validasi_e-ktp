import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validasi_ektp/validasi_form.dart';

import 'controller.dart';

class DetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SecondScreen();
  }
}

class _SecondScreen extends State<DetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Validasi E-KTP"),
        ),
        body: ValidasiForm(true));
  }
}
