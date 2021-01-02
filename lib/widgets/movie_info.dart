import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movietracker/bloc/get_movie_detail_bloc.dart';
import 'package:movietracker/model/movie_detail.dart';
import 'package:movietracker/model/movie_detail_response.dart';
import 'package:movietracker/style/theme.dart' as Style;

class MovieInfo extends StatefulWidget {
  final int id;

  const MovieInfo({Key key, @required this.id}) : super(key: key);

  @override
  _MovieInfoState createState() => _MovieInfoState(id);
}

class _MovieInfoState extends State<MovieInfo> {
  final int id;
  _MovieInfoState(this.id);

  @override
  void initState() {
    super.initState();
    movieDetailBloc..getMovieDetail(id);
  }

  void dispose() {
    super.dispose();
    movieDetailBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieDetailResponse>(
      stream: movieDetailBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieDetailResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildInfoWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Error occured: $error")]));
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.0,
            width: 25,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation(Colors.white),
              strokeWidth: 4.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoWidget(MovieDetailResponse data) {
    MovieDetail detail = data.movieDetail;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("BUDGET",
                      style: TextStyle(
                          color: Style.Colors.titleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(detail.budget.toString() + "\$",
                      style: TextStyle(
                          color: Style.Colors.secondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("DURATION",
                      style: TextStyle(
                          color: Style.Colors.titleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(detail.runtime.toString() + "min",
                      style: TextStyle(
                          color: Style.Colors.secondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("RELEASE DATE",
                      style: TextStyle(
                          color: Style.Colors.titleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(detail.releaseDate,
                      style: TextStyle(
                          color: Style.Colors.secondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0))
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("GENRES",
                  style: TextStyle(
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0)),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 40.0,
                padding: EdgeInsets.only(
                    right: 10.0, left: 10.0, top: 10.0, bottom: 6.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: detail.genres.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              border:
                                  Border.all(width: 1.0, color: Colors.white)),
                          child: Text(detail.genres[index].name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 9.0))),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
