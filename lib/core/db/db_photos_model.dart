import 'dart:typed_data';

class DBPhotosModel {
  final int id;
  final String url;
  final String photographer;
  final String avg_color;
  final Uint8List src;

  DBPhotosModel(
      {required this.id,
      required this.url,
      required this.photographer,
      required this.avg_color,
      required this.src});

  factory DBPhotosModel.fromJson(Map<String, dynamic> json) {
    return DBPhotosModel(
      id: json["id"],
      url: json["url"],
      photographer: json["photographer"],
      avg_color: json["avg_color"],
      src: json["src"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "url": url,
      "photographer": photographer,
      "avg_color": avg_color,
      "src": src,
    };
  }
}
