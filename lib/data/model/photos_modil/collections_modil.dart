
import 'collection_modil.dart';

class CollectionsModil {
  late final int page;
  final int per_page;
  final List<CollectionModil> collections;
  final int total_results;
  final String? prev_page;
  final String? next_page;

  CollectionsModil({
    required this.page,
    required this.per_page,
    required this.collections,
    required this.total_results,
    this.prev_page,
    this.next_page,
  });
  factory CollectionsModil.fromjson(Map<String, dynamic> json) {
   

    return CollectionsModil(
      page: json["page"],
      per_page: json["per_page"],
      total_results: json["total_results"],
      prev_page: json["prev_page"],
      next_page: json["next_page"],
      collections: List<CollectionModil>.from(
          json["collections"].map((e) =>CollectionModil.fromJson(e))).toList(),
    );
  }
}
