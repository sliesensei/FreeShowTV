import 'package:flutter/material.dart';
import 'package:movietracker/bloc/get_account_bloc.dart';
import 'package:movietracker/model/account_response.dart';


class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    accountBloc..getProfilInfo();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AccountResponse>(
        stream: accountBloc.subject,
        builder: (context, AsyncSnapshot<AccountResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildGenresWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        });
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

  Widget _buildGenresWidget(AccountResponse data) {
    return Container(
      child: Text("No Genre"),
    );
    //List<Genre> genres = data.genres;
    /*if (genres.length == 0) {
      return Container(
        child: Text("No Genre"),
      );
    } else
      return GenresList(genres: genres);
  }*/
  }
}
