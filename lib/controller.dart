import 'dart:io';

import 'package:get/get.dart';
import 'package:validasi_ektp/ktp_service.dart';
import 'package:validasi_ektp/validasi_form.dart';

import 'ktp_model.dart';

enum Validation { IDLE, VALID, NOT_VALID }

class Controller extends GetxController {
  final KtpService _ktpService;

  Controller(this._ktpService);

  Rx<Ktp> _ktp;

  Ktp get ktp => _ktp?.value;

  var _state = STATE.IDLE.obs;

  set ktp(Ktp ktp) => _ktp = ktp.obs;

  STATE get state => _state.value;

  bool validate() {
    if (_ktp.value.noKtp.length != 16) {
      return false;
    }
    if (_ktp.value.kodeTglLahir > 40 && _ktp.value.gender == "L") {
      return false;
    }
    if (_ktp.value.kodeTglLahir < 40 && _ktp.value.gender == "W") {
      return false;
    }
    if (_ktp.value.gender == "L" && _ktp.value.kodeTglLahir < 40) {
      if (_ktp.value.kodeTglLahir != _ktp.value.dateBirth.day) {
        return false;
      }
    }
    if (_ktp.value == "W" && _ktp.value.kodeTglLahir > 40) {
      if (_ktp.value.kodeTglLahir - 40 != _ktp.value.dateBirth.day) {
        return false;
      }
    }
    return true;
  }

  Future<bool> validateTwice() async {
    _state = STATE.LOADING.obs;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final response = await _ktpService.getWilayah(_ktp.value.kodeWilayah);
        bool isWilayahExists = response.isNotEmpty;
        if (isWilayahExists && validate()) {
          _state = STATE.SUCCESS.obs;
          return true;
        }
      }
    } on SocketException catch (_) {
      _state = STATE.SUCCESS.obs;
      throw Exception("No Internet Exception");
    } catch (e) {
      _state = STATE.SUCCESS.obs;
      return false;
    }
  }
}
