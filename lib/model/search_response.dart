import 'package:movietracker/model/search.dart';

class SearchResponse {
  final List<Search> videos;
  final String error;

  SearchResponse(this.videos, this.error);
  SearchResponse.fromJson(Map<String, dynamic> json)
      : videos =
            (json["results"] as List).map((i) => Search.fromJson(i)).toList(),
        error = "";

  SearchResponse.withError(String errorValue)
      : videos = [],
        error = errorValue;
}
