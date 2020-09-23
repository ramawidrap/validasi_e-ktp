
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:validasi_ektp/ktp_model.dart';

part 'ktp_service.g.dart';

@RestApi(baseUrl: "https://ibnux.github.io/data-indonesia/kelurahan/")
abstract class KtpService {
  factory KtpService(Dio dio) = _KtpService;

  @GET("/{kode}.json")
  Future<List<Ktp>> getWilayah(@Path("kode") String id);

}