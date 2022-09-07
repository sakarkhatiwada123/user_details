import 'package:dio/dio.dart';
import 'api_provider.dart';

class ApiProviderRepository {
  final ApiProvider _provider = ApiProvider();
  Future<Response> userDetailsRepo() async {
    return _provider.getUserDetail();
  }
}

final repository = ApiProviderRepository();
