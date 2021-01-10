import 'package:movietracker/model/account.dart';

class AccountResponse {
  final Account account;
  final String error;

  AccountResponse(this.account, this.error);
  AccountResponse.fromJson(Map<String, dynamic> json)
      : account  = (json["results"]).map((i) => Account.fromJson(i)).toList(),
        error = "";

  AccountResponse.withError(String errorValue)
      : account = null,
        error = errorValue;
}
