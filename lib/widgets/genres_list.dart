import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeshowtv/bloc/get_movies_byGenre_bloc.dart';
import 'package:freeshowtv/model/genre.dart';
import 'package:freeshowtv/style/theme.dart' as Style;
import 'package:freeshowtv/widgets/genres_movies.dart';

class GenresList extends StatefulWidget {
  final List<Genre> genres;
  GenresList({Key key, @required this.genres}) : super(key: key);
  @override
  _GenresListState createState() => _GenresListState(genres);
}

class _GenresListState extends State<GenresList>
    with SingleTickerProviderStateMixin {
  final List<Genre> genres;
  TabController _tabController;
  _GenresListState(this.genres);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: genres.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        moviesByGenreBloc..drainStream();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 307.0,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
            backgroundColor: Style.Colors.mainColor,
            appBar: PreferredSize(
                child: AppBar(
                  backgroundColor: Style.Colors.mainColor,
                  bottom: TabBar(
                      controller: _tabController,
                      indicatorColor: Style.Colors.secondColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 3.0,
                      unselectedLabelColor: Style.Colors.titleColor,
                      labelColor: Style.Colors.white,
                      isScrollable: true,
                      tabs: genres.map((Genre genre) {
                        return Container(
                            padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                            child: Text(genre.name.toUpperCase(),
                                style: TextStyle(
                                    fontSize: Style.FontSizes.size14,
                                    fontWeight: Style.FontWeights.bold)));
                      }).toList()),
                ),
                preferredSize: Size.fromHeight(50.0)),
            body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: genres.map((Genre genre) {
                return GenreMovies(genreId: genre.id);
              }).toList(),
            )),
      ),
    );
  }
}
