import 'package:get/get.dart';

import 'ktp.dart';

enum Validation {
  IDLE,
  VALID,
  NOT_VALID
}

class Controller extends GetxController {
  Rx<KTP> _ktp;

  get ktp => _ktp;

  set ktp(KTP ktp) => _ktp = ktp.obs;

  bool validate() {
    if(_ktp.value.noKtp.length != 16) {
      return false;
    }
    if(_ktp.value.kodeTglLahir > 40 && _ktp.value.gender == "L"){
      return false;
    }
    if(_ktp.value.kodeTglLahir < 40 && _ktp.value.gender == "W"){
      return false;
    }
    if(_ktp.value.gender == "L" && _ktp.value.kodeTglLahir < 40) {
      if(_ktp.value.kodeTglLahir != _ktp.value.dateBirth.day) {
        return false;
      }
    }
    if(_ktp.value == "W" && _ktp.value.kodeTglLahir > 40) {
      if(_ktp.value.kodeTglLahir-40 != _ktp.value.dateBirth.day) {
        return false;
      }
    }
    return true;
  }
}