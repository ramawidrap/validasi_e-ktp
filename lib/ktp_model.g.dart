// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ktp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ktp _$KtpFromJson(Map<String, dynamic> json) {
  return Ktp(
    json['noKtp'] as String,
    json['nama'] as String,
    json['gender'] as String,
    json['dateBirth'] == null
        ? null
        : DateTime.parse(json['dateBirth'] as String),
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$KtpToJson(Ktp instance) => <String, dynamic>{
      'id': instance.id,
      'nama': instance.name,
      'noKtp': instance.noKtp,
      'gender': instance.gender,
      'dateBirth': instance.dateBirth?.toIso8601String(),
    };
