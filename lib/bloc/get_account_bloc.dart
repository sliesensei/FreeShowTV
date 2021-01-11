import 'package:freeshowtv/model/account_response.dart';
import 'package:freeshowtv/repository/user.dart';
import 'package:rxdart/subjects.dart';

class AccountBloc {
  final UserRepository _repository = UserRepository();
  final BehaviorSubject<AccountResponse> _subject =
      BehaviorSubject<AccountResponse>();

  getProfilInfo() async {
    AccountResponse response = await _repository.getProfilInfo();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<AccountResponse> get subject => _subject;
}

final accountBloc = AccountBloc();
