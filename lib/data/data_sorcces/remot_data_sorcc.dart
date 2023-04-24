import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photos/core/error/exception.dart';
import 'package:photos/data/model/photos_modil/collections_modil.dart';
import 'package:photos/data/model/photos_modil/photos_modil.dart';

abstract class RemotDataSorcc {
  Future<PhotosModil> gitPhoto({int? page, int? per_page, String? nextPage});
  Future<PhotosModil> getSearchValeu(
      {int? page,
      int? per_page,
      String? categore,
      String? color,
      String? nextPage});
  Future<CollectionsModil> getCollections({String? nextPage});
  Future<double> download(String url);
}

class DataSorccWithDio implements RemotDataSorcc {
  final Dio dio = Dio();
  String key = "563492ad6f9170000100000135c71c1e573943a8994cf9cbb9d58492";
  String url = "https://api.pexels.com/v1/curated";
  String searchURL = "https://api.pexels.com/v1/search";
  String collectionsURL = "https://api.pexels.com/v1/collections/";

  @override
  // Method for fetching all images without limitation
  Future<PhotosModil> gitPhoto(
      {int? page, int? per_page, String? nextPage}) async {
    print("ren data surss ");
    final data = await dio.get(
      nextPage ?? url,
      queryParameters: nextPage == null
          ? {
              "page": page,
              "per_page": per_page,
            }
          : null,
      options: Options(
        headers: {"Authorization": key},
      ),
    );

    if (data.statusCode == 200) {
      final jsonToDart = PhotosModil.fromjson(data.data);
      if (jsonToDart.photos.isEmpty) {
        throw NoDateException();
      } else {
        return jsonToDart;
      }
    } else {
      print("error data .....");
      throw ServerException();
    }
  }

  @override
  Future<PhotosModil> getSearchValeu(
      {int? page,
      int? per_page,
      String? categore,
      String? color,
      String? nextPage}) async {
    final searchValue = await dio.get(
      nextPage ?? searchURL,
      queryParameters: nextPage == null
          ? {
              "page": page,
              "per_page": per_page,
              "query": categore,
              "color": color
            }
          : null,
      options: Options(
        headers: {"Authorization": key},
      ),
    );
    if (searchValue.statusCode == 200) {
      final jsonToDart = PhotosModil.fromjson(searchValue.data);
      if (jsonToDart.photos.isEmpty) {
        throw NoDateException();
      } else {
        return jsonToDart;
      }
    } else {
      print("error data .....");
      throw ServerException();
    }
  }

  Future<CollectionsModil> getCollections({String? nextPage}) async {
    final collections = await dio.get(
      nextPage ?? collectionsURL + "featured",
      queryParameters: nextPage == null
          ? {
              "page": 1,
              "per_page": 80,
            }
          : null,
      options: Options(
        headers: {"Authorization": key},
      ),
    );
    if (collections.statusCode == 200) {
      print(collections);
      final jsonToDart = CollectionsModil.fromjson(collections.data);
      if (jsonToDart.collections.isEmpty) {
        throw NoDateException();
      } else {
        return jsonToDart;
      }
    } else {
      print("error data .....");
      throw ServerException();
    }
  }

  @override
  Future<double> download(String url) async {
    final savePath = '${(await getTemporaryDirectory()).path}/image.jpg';
     double progress = 0.0;
  var response= dio.download(
      url,
      savePath,
      onReceiveProgress: (count, total) {
        progress = (count / total);
      },
    );
    if (response.hashCode==200){
      return progress;
    }else{
      print("error download .....");
      throw ServerException();
    }
    
  }
}
