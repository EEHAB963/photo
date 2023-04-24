import 'package:photos/data/model/photos_modil/src_modil.dart';

class PhotoModil {
  final int id;
  final int width;
  final int height;
  final String url;
  final String photographer;
  final String photographer_url;
  final int photographer_id;
  final String avg_color;
  final String alt;
  final SrcModil src;

  PhotoModil({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.photographer,
    required this.photographer_url,
    required this.photographer_id,
    required this.avg_color,
    required this.alt,
    required this.src,
  });
  factory PhotoModil.fromJson(Map<String, dynamic> json) {
    return PhotoModil(
      id: json["id"],
      width: json["width"],
      height: json["height"],
      url: json["url"],
      photographer: json["photographer"],
      photographer_url: json["photographer_url"],
      photographer_id: json["photographer_id"],
      avg_color: json["avg_color"],
      alt: json["alt"],
      src: SrcModil.fromJson(
        json["src"],
      ),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "width": width,
      "height": height,
      "url": url,
      "photographer": photographer,
      "photographer_url": photographer_url,
      "photographer_id": photographer_id,
      "avg_color": avg_color,
      "src":src,
    };
  }
}
