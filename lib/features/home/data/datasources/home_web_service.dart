import 'package:dio/dio.dart';
import 'package:dio_pretty_logger/dio_pretty_logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HomeWebService {
  final dio = Dio()
    ..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: false,
      ),
    );

  HomeWebService() {
    dio.options.baseUrl = 'https://dummyjson.com/';
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.sendTimeout = const Duration(seconds: 30);
  }
  Future<Response> getHomeData() async {
    var result = await dio.get(
      dio.options.baseUrl + 'products',
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    return result;
  }
}
