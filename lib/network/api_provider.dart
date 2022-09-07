//get user_details api
import 'package:dio/dio.dart';
import 'api_endpoint.dart';

class ApiProvider {
  Future<Response> getUserDetail() async {
    Dio dio = Dio();
    return await dio.get(APIs.user_details_api,
        options: Options(headers: {"Accept": "application/json"}));
  }
}
