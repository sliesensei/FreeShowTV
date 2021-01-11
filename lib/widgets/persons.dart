import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freeshowtv/bloc/get_persons_bloc.dart';
import 'package:freeshowtv/model/person.dart';
import 'package:freeshowtv/model/person_response.dart';
import 'package:freeshowtv/style/theme.dart' as Style;
import 'package:freeshowtv/constant/constants.dart';

class PersonsList extends StatefulWidget {
  @override
  _PersonsListState createState() => _PersonsListState();
}

class _PersonsListState extends State<PersonsList> {
  @override
  void initState() {
    super.initState();
    personsBloc.getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 10.0, top: 20.0),
            child: Text("TRENDING PERSONS ON THIS WEEK",
                style: TextStyle(
                    color: Style.Colors.titleColor,
                    fontWeight: Style.FontWeights.w500,
                    fontSize: Style.FontSizes.size12))),
        SizedBox(height: 5.0),
        StreamBuilder<PersonResponse>(
          stream: personsBloc.subject.stream,
          builder: (context, AsyncSnapshot<PersonResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return _buildErrorWidget(snapshot.data.error);
              }
              return _buildPersonsWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        )
      ],
    );
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
              valueColor: new AlwaysStoppedAnimation(Style.Colors.white),
              strokeWidth: 4.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Error occured: $error")]));
  }

  Widget _buildPersonsWidget(PersonResponse data) {
    List<Person> persons = data.persons;
    return Container(
        height: 140.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          itemCount: persons.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: 90.0,
              padding: EdgeInsets.only(top: 10, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  persons[index].profileImg == null
                      ? Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Style.Colors.secondColor),
                          child: Icon(FontAwesomeIcons.userAlt,
                              color: Style.Colors.white))
                      : Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      Constants.imageUrl +
                                          persons[index].profileImg),
                                  fit: BoxFit.cover)),
                        ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    persons[index].name,
                    maxLines: 2,
                    style: TextStyle(
                        height: 1.4,
                        color: Style.Colors.white,
                        fontWeight: Style.FontWeights.bold,
                        fontSize: Style.FontSizes.size9),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text("Trending for ${persons[index].known}",
                      style: TextStyle(
                          color: Style.Colors.titleColor,
                          fontWeight: Style.FontWeights.w400,
                          fontSize: Style.FontSizes.size7))
                ],
              ),
            );
          },
        ));
  }
}
