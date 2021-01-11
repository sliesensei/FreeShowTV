import 'package:freeshowtv/model/login_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freeshowtv/model/account_response.dart';

class UserRepository {
  final String apiKey = "7e63f4a608a66fe5cda8dc659ac2bfb3";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();

  var accountUrl = '$mainUrl/account';
  var getRequestToken = '$mainUrl/authentication/token/new';
  var loginIn = '$mainUrl/authentication/token/validate_with_login';
  var getSession = '$mainUrl/authentication/session/new';

  Future<Dio> getApiClient() async {
    final db = await SharedPreferences.getInstance();
    final sessionId = db.getString('sessionId');
    _dio.interceptors.clear();
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.queryParameters = {
        "api_key": apiKey,
        "language": "en-US",
        "session_id": sessionId
      };
      return options;
    }, onResponse: (Response response) {
      return response;
    }, onError: (DioError error) async {
      if (error.response?.statusCode == 401) {
        _dio.interceptors.requestLock.lock();
        _dio.interceptors.responseLock.lock();
        RequestOptions options = error.response.request;
        _dio.interceptors.requestLock.unlock();
        _dio.interceptors.responseLock.unlock();
        return _dio.request(options.path, options: options);
      } else {
        return error;
      }
    }));
    _dio.options.baseUrl = mainUrl;
    return _dio;
  }

  Future<AccountResponse> getProfilInfo() async {
    final db = await SharedPreferences.getInstance();
    final sessionId = db.getString('sessionId') ?? null;

    var params = {"api_key": apiKey, "session_id": sessionId};
    try {
      Response response = await _dio.get(accountUrl, queryParameters: params);
      final data = AccountResponse.fromJson(response.data);
      return data;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return AccountResponse.withError("$error");
    }
  }

  Future<bool> login(String email, String pass) async {
    final db = await SharedPreferences.getInstance();

    try {
      var params = {"api_key": apiKey, "language": "en-US"};
      Response response =
          await _dio.get(getRequestToken, queryParameters: params);
      final requestToken = RequestTokenResponse.fromJson(response.data);

      Response validateToken = await _dio.post(loginIn, queryParameters: {
        "api_key": apiKey
      }, data: {
        "username": email,
        "password": pass,
        "request_token": requestToken.requestToken
      });

      if (validateToken.statusCode == 200) {
        db.setString('requestToken', requestToken.requestToken);
        final validToken =
            ValidateRequestTokenResponse.fromJson(validateToken.data);
        Response resSession = await _dio.post(getSession,
            queryParameters: {"api_key": apiKey},
            data: {"request_token": validToken.requestToken});
        final sessionId = SessionIdResponse.fromJson(resSession.data);
        db.setString('sessionId', sessionId.sessionId);
        return (true);
      } else
        return (false);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return (false);
    }
  }

  Future logout() async {
    final db = await SharedPreferences.getInstance();
    db.remove("requestToken");
    db.remove("sessionId");
  }
}
