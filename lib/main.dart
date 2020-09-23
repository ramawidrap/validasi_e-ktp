import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validasi_ektp/first_screen.dart';

import 'controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Controller controller = Get.put(Controller());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: FirstScreen(),
    );
  }
}

