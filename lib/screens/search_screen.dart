
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:movietracker/model/movie.dart';
import 'package:movietracker/repository/repository.dart';
import 'package:movietracker/style/theme.dart' as Style;
import 'package:movietracker/screens/detail_screen.dart';

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
  }

  @override
  void dispose() {
    super.dispose();
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
