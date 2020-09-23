import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validasi_ektp/InputScreen.dart';
import 'package:validasi_ektp/ktp_service.dart';

import 'controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Controller controller = Get.put(Controller(KtpService(Dio())));

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: InputScreen(),
    );
  }
}
