import 'package:photos/core/db/db_photos_model.dart';
import 'package:photos/core/error/exception.dart';

import '../../core/db/db_provider.dart';

abstract class LocalDataSorcces {
  Future<List<DBPhotosModel>> getPhotos();
  Future setPhoto(DBPhotosModel dbPhotosModel);
  Future deletePhoto(int id);
}

class LocalDataSorccrsWithSQflit implements LocalDataSorcces {
  @override
  Future deletePhoto(int id) async {
    await DBprovider.instance.delete(id);
  }

  @override
  Future<List<DBPhotosModel>> getPhotos() async {
    final data = await DBprovider.instance.ReadDataAll();
    if (data.isNotEmpty) {
      return data;
    } else {
      throw NoDateException();
    }
  }

  @override
  Future setPhoto(DBPhotosModel dbPhotosModel) async {
    await DBprovider.instance.cerateUser(dbPhotosModel);
  }
}
