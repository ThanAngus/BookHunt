import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../models/config.dart';

class HTTPService{
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  late String baseUrl;
  late String apiKey;

  HTTPService(){
    AppConfig config = getIt.get<AppConfig>();
    baseUrl = config.baseUrl;
  }

  Future<Response?> get(int page, {Map<String, dynamic>? customQuery}) async{
    String url = baseUrl;
    Map<String, dynamic> query = {
      'page' : page,
    };
    if(customQuery != null){
      query.addAll(customQuery);
    }
    return await dio.get(url, queryParameters: query);
  }
}