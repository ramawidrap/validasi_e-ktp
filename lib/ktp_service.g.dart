// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ktp_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _KtpService implements KtpService {
  _KtpService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://ibnux.github.io/data-indonesia/kelurahan/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getWilayah(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/$id.json',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Ktp.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
