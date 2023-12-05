import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../common/constants/storage_contants.dart';
import '../../../main.dart';
import 'api_constants.dart';

class DioClient {
  static final DioClient _singleton = DioClient._internal();
  late Dio instance;

  factory DioClient() {
    return _singleton;
  }

  DioClient._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    );
    options.connectTimeout = 30000;
    options.receiveTimeout = 30000;

    instance = Dio();

    instance.options = options;
    instance.interceptors.add(PrettyDioLogger());
    instance.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options,
          RequestInterceptorHandler requestInterceptorHandler) async {
        print("${options.method} ${options.path}");
        print("request body = ${options.data}");
        options.headers['Accept'] = 'application/json';
        options.headers['Content-Type'] = 'application/json';
        options.headers['Authorization'] =
            'Bearer ' + userBox.get(StorageConstants.userToken).toString();

        print("headers = ${options.headers} ");

        return requestInterceptorHandler.next(options);
      },
      onResponse: (Response response,
          ResponseInterceptorHandler responseInterceptorHandler) {
        print(response.statusCode);
        return responseInterceptorHandler.next(response);
      },
      onError:
          (DioError e, ErrorInterceptorHandler errorInterceptorHandler) async {
        print(e.response?.statusCode);

        return errorInterceptorHandler.next(e);
      },
    ));
  }
}
