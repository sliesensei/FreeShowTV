import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movietracker/bloc/get_movie_search_bloc.dart';
import 'package:movietracker/model/movie.dart';
import 'package:movietracker/model/search.dart';
import 'package:movietracker/model/video_response.dart';
import 'package:movietracker/screens/video_player.dart';
import 'package:movietracker/repository/repository.dart';
import 'package:movietracker/style/theme.dart' as Style;
import 'package:movietracker/screens/detail_screen.dart';
import 'package:movietracker/widgets/casts.dart';
import 'package:movietracker/widgets/movie_info.dart';
import 'package:movietracker/widgets/similar_movies.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SearchScreen extends StatefulWidget {
  //SearchScreen({Key key}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //final Movie movie;
  final MovieRepository _repository = MovieRepository();
  _SearchScreenState();

  @override
  void initState() {
    super.initState();
    //movieVideosBloc..getMovieVideos(movie.id);
  }

  @override
  void dispose() {
    super.dispose();
    //movieVideosBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text("Search"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar<Movie>(
            minimumChars: 1,
            listPadding: EdgeInsets.symmetric(vertical: 10),
            cancellationWidget: Text("Cancel",
                style: TextStyle(
                    color: Style.Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold)),
            emptyWidget: Text("empty"),
            onCancelled: () {
              print("Cancelled triggered");
            },
            onSearch: _repository.searchMovie,
            onItemFound: (Movie movie, int index) {
              print(movie.title);
              return ListTile(
                title: Text(
                    movie.title.length > 40
                        ? movie.title.substring(0, 37) + "..."
                        : movie.title,
                    style: TextStyle(
                        color: Style.Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold)),
                subtitle: Text(
                    movie.overview.length > 120
                        ? movie.overview.substring(0, 117) + "..."
                        : movie.overview,
                    style: TextStyle(
                      color: Style.Colors.white,
                      fontSize: 12.0,
                    )),
                leading: movie.poster != null
                    ? Image.network(
                        "https://image.tmdb.org/t/p/w200/" + movie.poster)
                    : null,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailScreen(movie: movie)));
                  // do something
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
