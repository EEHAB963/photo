
import 'package:path/path.dart';
import 'package:photos/core/db/constans.dart';
import 'package:photos/core/db/db_photos_model.dart';
import 'package:photos/data/model/photos_modil/photo_modil.dart';
import 'package:sqflite/sqflite.dart';

class DBprovider {
  static final DBprovider instance = DBprovider._inst();
  DBprovider._inst();
  static Database? _database;
  Future<Database>? get database async {
    if (_database != null) _database;
    _database = await _initDB();
    return _database!;
  }

  ///build DB and openDB
  Future<Database>? _initDB() async {
    String path = join(await getDatabasesPath(), 'PhotoDatabase');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _cerateDB,
    );
  }

  ///CerateBD
  Future<void> _cerateDB(Database database, int version) async {
    await database.execute('''
CREATE TABLE $tableName (
  $columnID $idType,
  $columnPhotographer $textType,
  $columnSrc $bLOBType,
  $columnAvgcolor $textType,
  $columnUrl $textType
)
''');
  }

  /// CerateUser
  Future<void> cerateUser(DBPhotosModel photoDB) async {
    final db = await instance.database;
    db!.insert(tableName, photoDB.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  ///UpDate
  Future<void> updareUser(DBPhotosModel photoDB) async {
    final db = await instance.database;
    db!.update(
      tableName,
      photoDB.toJson(),
      where: '$columnID = ?',
      whereArgs: [photoDB.id],
    );
  }

  ///Delete
  Future<void> delete(int id) async {
    final db = await instance.database;
    db!.delete(
      tableName,
      where: '$columnID = ? ',
      whereArgs: [id],
    );
  }

  /// Read one Elememt

  Future<DBPhotosModel> readOne(int id) async {
    final db = await instance.database;
    final data = await db!.query(
      tableName,
      where: '$columnID=?',
      whereArgs: [id],
    );
    return data.isNotEmpty
        ? DBPhotosModel.fromJson(data.first)
        : throw Exception('there is data');
  }

  ///Read all elemnts

  Future<List<DBPhotosModel>> ReadDataAll() async {
    final db = await instance.database;
    final data = await db!.query(tableName);
    return data.isNotEmpty ? data.map((e) => DBPhotosModel.fromJson(e)).toList() : [];
  }
}
