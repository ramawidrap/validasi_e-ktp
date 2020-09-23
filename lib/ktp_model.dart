import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ktp_model.g.dart';

@JsonSerializable()
class Ktp {
  @JsonKey(name: "id")
  String id;

  @JsonKey(name: "nama")
  String name;


  String noKtp;

  String gender;

  DateTime dateBirth;

  Ktp(this.noKtp, this.name, this.gender, this.dateBirth,{this.id});

  factory Ktp.fromJson(Map<String,dynamic> json) => _$KtpFromJson(json);
  
  String get kodeProvinsi => noKtp.substring(0,2);

  String get kodeKota => noKtp.substring(2,4);

  String get kodeKecamatan => noKtp.substring(4,6);

  int get kodeTglLahir => int.parse(noKtp.substring(6,8));

  String get kodeBlnLahir => noKtp.substring(8,10);

  String get kodeThnLahir => noKtp.substring(10,12);

  String get KodeUrut => noKtp.substring(12,16);

  String get kodeWilayah => noKtp.substring(0,6);



}

class ControllerKTP extends ValueNotifier<Ktp> {
  ControllerKTP({Ktp initialValue}) : super(initialValue);
}