class CollectionModil {
  final String id;
  final String title;
  final int photos_count;

  CollectionModil(
      {required this.id, required this.title, required this.photos_count});
  factory CollectionModil.fromJson(Map<String,dynamic> json) {
    return CollectionModil(
        id: json["id"],
        title: json["title"],
        photos_count: json["photos_count"]);
  }
}
