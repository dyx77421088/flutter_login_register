
import 'package:dio/dio.dart';
import 'config.dart';

class HttpRequest {
  static final BaseOptions baseOptions = BaseOptions(baseUrl: HttpConfig.baseURL, connectTimeout: HttpConfig.timeout);
  final Dio dio = Dio(baseOptions);


  Future<T> request<T>(String url, {String method = "get", Map<String, dynamic> params, Interceptor inter}) async{
    print('url=$url');

    // 创建单独配置
    final options = Options(method: method);

    // 全局的拦截器
    // 创建默认的全局拦截器
    Interceptor dInter = InterceptorsWrapper(
      // 请求拦截
      onRequest: (options) {
        print('请求拦截');
      return options;
      },
      // 响应拦截
      onResponse: (response) {
        print('响应拦截');
      return response;
      },
      // 错误拦截
      onError: (error) {
        print('错误拦截');
      return error;
      }
    );

    List<Interceptor> inters = [dInter];

    // 自定义的拦截器
    if(inter != null) {
      inters.add(inter);
    }

    dio.interceptors.addAll(inters);


    // 发送网络请求
    try {
      Response response = await dio.request(url, queryParameters: params, options: options);
      return response.data;
    } on DioError catch(e) {
      return Future.error(e);
    }
  }
}