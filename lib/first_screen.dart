import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controller.dart';
import 'ktp.dart';

class FirstScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstScreen();
  }
}

class _FirstScreen extends State<FirstScreen> {
  final _noKtpController = TextEditingController();
  final _namaKtpController = TextEditingController();
  final _genderKtpController = TextEditingController();
  final _tglLahirKtpController = TextEditingController();
  final Controller _controller = Get.find();

  final _formKey = GlobalKey<FormState>()

  final f = new DateFormat('yyyy-MM-dd hh:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "No KTP"),
                  controller: _noKtpController,

                ),
                TextFormField(
                  controller: _namaKtpController,
                  decoration: InputDecoration(labelText: "Nama KTP"),
                ),
                TextFormField(
                  controller: _genderKtpController,
                  decoration: InputDecoration(labelText: "Kelamin KTP"),
                ),
                TextFormField(
                  onTap: () async => _setDate(),
                  readOnly: true,
                  controller: _tglLahirKtpController,
                  decoration: InputDecoration(labelText: "Tanggal Lahir KTP"),
                ),
                RaisedButton(
                  onPressed: () {
                    _controller.ktp = KTP(
                        _noKtpController.text,
                        _namaKtpController.text,
                        _genderKtpController.text,
                        f.parse(_tglLahirKtpController.text));
                  },
                  child: Text("Validasi"),
                )
              ],
            ),
          ),
        ));
  }

  _setDate() async {
    final date = await showDatePicker(
        context: context, initialDate: null, firstDate: null, lastDate: null);
    final formattedDate = f.format(date);
    setState(() {
      _tglLahirKtpController.text = formattedDate;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _noKtpController.dispose();
    _namaKtpController.dispose();
    _genderKtpController.dispose();
    _tglLahirKtpController.dispose();
  }
}
