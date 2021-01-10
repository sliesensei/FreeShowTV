class Account {
  final String id;
  final String username;
  final String avatar;
  final String name;
  final String includeAdult;

  Account(this.id, this.username, this.name, this.avatar, this.includeAdult );

  Account.fromJson(Map<String, dynamic> json)
      : id = json["id"].toString(),
        avatar = json["avatar"]["gravatar"]["hash"] ? json["avatar"]["gravatar"]["hash"] : "",
        name = json["name"],
        username = json["username"],
        includeAdult = json["include_adult"];
}
