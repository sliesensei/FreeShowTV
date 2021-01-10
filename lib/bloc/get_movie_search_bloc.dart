import 'package:flutter/widgets.dart';
import 'package:movietracker/model/search_response.dart';
import 'package:movietracker/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

/*class MovieSearchBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<SearchResponse> _subject =
      BehaviorSubject<SearchResponse>();

  getMovieDetail(String query) async {
    SearchResponse response = await _repository.searchMovie(query);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<SearchResponse> get subject => _subject;
}

final movieSearchBloc = MovieSearchBloc();*/
