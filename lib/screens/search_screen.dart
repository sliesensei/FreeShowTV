import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:freeshowtv/model/movie.dart';
import 'package:freeshowtv/repository/repository.dart';
import 'package:freeshowtv/style/theme.dart' as Style;
import 'package:freeshowtv/screens/detail_screen.dart';
import 'package:freeshowtv/constant/constants.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
                    fontSize: Style.FontSizes.size14,
                    fontWeight: Style.FontWeights.bold)),
            emptyWidget: Text("No result",
                style: TextStyle(
                    color: Style.Colors.white,
                    fontSize: Style.FontSizes.size14,
                    fontWeight: Style.FontWeights.bold)),
            onCancelled: () {
              print("Cancelled triggered");
            },
            searchBarStyle: SearchBarStyle(
              backgroundColor: Style.Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            onSearch: _repository.searchMovie,
            onItemFound: (Movie movie, int index) {
              return ListTile(
                title: Text(
                    movie.title.length > 40
                        ? movie.title.substring(0, 37) + "..."
                        : movie.title,
                    style: TextStyle(
                        color: Style.Colors.white,
                        fontSize: Style.FontSizes.size14,
                        fontWeight: Style.FontWeights.bold)),
                subtitle: Text(
                    movie.overview.length > 120
                        ? movie.overview.substring(0, 117) + "..."
                        : movie.overview,
                    style: TextStyle(
                      color: Style.Colors.white,
                      fontSize: Style.FontSizes.size12,
                    )),
                leading: movie.poster != null
                    ? Image.network(Constants.imageUrl + movie.poster)
                    : null,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailScreen(movie: movie)));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
