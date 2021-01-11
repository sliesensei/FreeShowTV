import 'package:freeshowtv/model/cast_response.dart';
import 'package:freeshowtv/model/genre_response.dart';
import 'package:freeshowtv/model/movie_detail_response.dart';
import 'package:freeshowtv/model/movie_response.dart';
import 'package:freeshowtv/model/movie.dart';
import 'package:dio/dio.dart';
import 'package:freeshowtv/model/person_response.dart';
import 'package:freeshowtv/model/video_response.dart';
import 'package:freeshowtv/constant/constants.dart';

class MovieRepository {
  final Dio _dio = Dio();
  static const String mainUrl = Constants.mainUrl;
  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGeneresUrl = '$mainUrl/genre/movie/list';
  var getPersonUrl = '$mainUrl/trending/person/week';
  var movieUrl = '$mainUrl/movie';
  var searchUrl = '$mainUrl/search/movie';

  Future<MovieResponse> getMovies() async {
    var params = {"api_key": Constants.apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception ocurred: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getPlayingMovies() async {
    var params = {"api_key": Constants.apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
          await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception ocurred: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<GenreResponse> getGenres() async {
    var params = {"api_key": Constants.apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
          await _dio.get(getGeneresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception ocurred: $error stackTrace: $stacktrace");
      return GenreResponse.withError("$error");
    }
  }

  Future<PersonResponse> getPersons() async {
    var params = {
      "api_key": Constants.apiKey,
    };
    try {
      Response response = await _dio.get(getPersonUrl, queryParameters: params);
      print(response.toString());
      return PersonResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception ocurred: $error stackTrace: $stacktrace");
      return PersonResponse.withError("$error");
    }
  }

  Future<MovieResponse> getMovieByGenre(int id) async {
    var params = {
      "api_key": Constants.apiKey,
      "language": "en-US",
      "page": 1,
      "with_genres": id
    };
    try {
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception ocurred: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getPopular() async {
    var params = {"api_key": Constants.apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception ocurred: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieDetailResponse> getMovieDetail(int id) async {
    var params = {"api_key": Constants.apiKey, "language": "en-US"};

    try {
      Response response =
          await _dio.get(movieUrl + "/$id", queryParameters: params);
      return MovieDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieDetailResponse.withError("$error");
    }
  }

  Future<CastResponse> getCasts(int id) async {
    var params = {"api_key": Constants.apiKey, "language": "en-US"};
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/credits",
          queryParameters: params);
      return CastResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CastResponse.withError("$error");
    }
  }

  Future<MovieResponse> getSimilarMovies(int id) async {
    var params = {"api_key": Constants.apiKey, "language": "en-US"};
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/similar",
          queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<VideoResponse> getMovieVideos(int id) async {
    var params = {"api_key": Constants.apiKey, "language": "en-US"};
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/videos",
          queryParameters: params);
      return VideoResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VideoResponse.withError("$error");
    }
  }

  Future<List<Movie>> searchMovie(String query) async {
    var params = {
      "api_key": Constants.apiKey,
      "language": "en-US",
      "query": query
    };
    try {
      Response response = await _dio.get(searchUrl, queryParameters: params);
      if (response.statusCode == 200) {
        List<Movie> res = (response.data["results"] as List)
            .map((i) => Movie.fromJson(i))
            .toList();
        return res;
      } else
        return [];
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return [];
    }
  }
}
