class Search {
  final String id;
  final String poster;
  final String name;

  Search(this.id, this.poster, this.name);

  Search.fromJson(Map<String, dynamic> json)
      : id = json["id"].toString(),
        poster = json["poster_path"],
        name = json["title"];
}
