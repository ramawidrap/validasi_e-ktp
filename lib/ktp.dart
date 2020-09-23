class KTP {
  String noKtp;
  String name;
  String gender;
  DateTime dateBirth;

  KTP(this.noKtp, this.name, this.gender, this.dateBirth);
  
  String get kodeProvinsi => noKtp.substring(0,2);

  String get kodeKota => noKtp.substring(2,4);

  String get kodeKecamatan => noKtp.substring(4,6);

  int get kodeTglLahir => int.parse(noKtp.substring(6,8));

  String get kodeBlnLahir => noKtp.substring(8,10);

  String get kodeThnLahir => noKtp.substring(10,12);

  String get KodeUrut => noKtp.substring(12,16);

}