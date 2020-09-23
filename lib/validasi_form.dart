import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:validasi_ektp/detail_screen.dart';

import 'controller.dart';
import 'ktp_model.dart';

class ValidasiForm extends StatefulWidget {
  bool isReadOnly;

  ValidasiForm(@required this.isReadOnly);

  @override
  State<StatefulWidget> createState() {
    return _ValidasiForm();
  }
}

class _ValidasiForm extends State<ValidasiForm> {
  final _noKtpController = TextEditingController();
  final _namaKtpController = TextEditingController();
  final _tglLahirKtpController = TextEditingController();
  var _gender = "L";
  final Controller _controller = Get.find();
  final f = new DateFormat('dd-MM-yyyy');
  final _formKey = GlobalKey<FormState>();

  var _state = STATE.IDLE;

  @override
  void initState() {
    super.initState();
    final ktp = _controller.ktp;
    if (widget.isReadOnly && ktp != null) {
      _noKtpController.text = ktp.noKtp;
      _namaKtpController.text = ktp.name;
      _gender = ktp.gender;
      _tglLahirKtpController.text = f.format(ktp.dateBirth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  readOnly: widget.isReadOnly,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "No KTP"),
                  controller: _noKtpController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  readOnly: widget.isReadOnly,
                  controller: _namaKtpController,
                  decoration: InputDecoration(labelText: "Nama KTP"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Kelamin KTP"),
                      Row(children: [
                        Expanded(
                            flex: 1,
                            child: ListTile(
                              title: Text("Pria"),
                              leading: Radio(
                                  value: "L",
                                  groupValue: _gender,
                                  onChanged: widget.isReadOnly
                                      ? null
                                      : (value) {
                                          setState(() {
                                            _gender = value;
                                          });
                                        }),
                            )),
                        Expanded(
                            flex: 1,
                            child: ListTile(
                              title: Text("Wanita"),
                              leading: Radio(
                                  value: "W",
                                  groupValue: _gender,
                                  onChanged: widget.isReadOnly
                                      ? null
                                      : (value) {
                                          setState(() {
                                            _gender = value;
                                          });
                                        }),
                            ))
                      ])
                    ],
                  ),
                ),
                TextFormField(
                  onTap: widget.isReadOnly
                      ? null
                      : () async {
                          await _setDate();
                        },
                  readOnly: true,
                  controller: _tglLahirKtpController,
                  decoration: InputDecoration(labelText: "Tanggal Lahir KTP"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                RaisedButton(
                  onPressed: widget.isReadOnly
                      ? () async {
                          _showDialog();
                        }
                      : () {
                          if (_formKey.currentState.validate()) {
                            _controller.ktp = Ktp(
                                _noKtpController.text,
                                _namaKtpController.text,
                                _gender,
                                f.parse(_tglLahirKtpController.text));
                            Get.to(DetailScreen());
                          }
                        },
                  child: Text(widget.isReadOnly ? "Proses" : "Validasi"),
                )
              ],
            )));
  }

  _setDate() async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1500),
        lastDate: DateTime.now());
    if (date != null) {
      final formattedDate = f.format(date);
      setState(() {
        _tglLahirKtpController.text = formattedDate;
      });
    }
  }

  _showDialog() async {
    var message = "";
    var assets = "";
    try {
      final isValid = await _controller.validateTwice();
      message = isValid ? "KTP Valid" : "KTP Tidak Valid";
      assets = isValid ? "assets/valid.png" : "assets/notvalid.png";
    } on Exception catch (error) {
      message = error.toString();
      assets = "assets/nointernet.png";
    }

    final dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        alignment: Alignment.center,
        height: 150,
        width: 150,
        child: _controller.state == STATE.LOADING
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(assets), fit: BoxFit.fill)),
                  ),
                  Text(message)
                ],
              ),
      ),
    );

    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  @override
  void dispose() {
    super.dispose();
    _noKtpController.dispose();
    _namaKtpController.dispose();
    _tglLahirKtpController.dispose();
  }
}

enum STATE { IDLE, LOADING, SUCCESS }
