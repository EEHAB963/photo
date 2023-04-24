import 'package:photos/data/model/photos_modil/photo_modil.dart';

class PhotosModil {
  late final int page;
  final int per_page;
  final List<PhotoModil> photos;
  final int total_results;
  final String? prev_page;
  final String? next_page;

  PhotosModil({
    required this.page,
    required this.per_page,
    required this.photos,
    required this.total_results,
    this.prev_page,
    this.next_page,
  });
  factory PhotosModil.fromjson(Map<String, dynamic> json) {
   

    return PhotosModil(
      page: json["page"],
      per_page: json["per_page"],
      total_results: json["total_results"],
      prev_page: json["prev_page"],
      next_page: json["next_page"],
      photos: List<PhotoModil>.from(
          json["photos"].map((e) => PhotoModil.fromJson(e))).toList(),
    );
  }
}
