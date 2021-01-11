class AccountResponse {
  final String id;
  final String username;
  final String avatar;
  final String name;
  final String includeAdult;

  AccountResponse(
      {this.id, this.username, this.name, this.avatar, this.includeAdult});

  factory AccountResponse.fromJson(Map<String, dynamic> json) {
    return AccountResponse(
      id: json["id"].toString(),
      avatar: json["avatar"]["gravatar"]["hash"],
      name: json["name"],
      username: json["username"],
      includeAdult: json["include_adult"].toString(),
    );
  }
  factory AccountResponse.withError(String errorValue) {
    return AccountResponse(
        id: errorValue,
        avatar: null,
        name: null,
        username: null,
        includeAdult: null);
  }
}
