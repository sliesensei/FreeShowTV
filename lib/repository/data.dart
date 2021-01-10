import 'package:dio/dio.dart';
import 'package:movietracker/model/account_response.dart';

class DatabaseRepository {
  final String apiKey = "7d039bce864f6ec288abc6f2e0124f22";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();

  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGeneresUrl = '$mainUrl/genre/movie/list';
  var getPersonUrl = '$mainUrl/trending/person/week';
  var movieUrl = '$mainUrl/movie';
  var searchUrl = '$mainUrl/search/movie';
  var accountUrl = '$mainUrl/account';


  Future<AccountResponse> getProfilInfo() async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response = await _dio.get(accountUrl ,
          queryParameters: params);
      return AccountResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return AccountResponse.withError("$error");
    }
  }

}
