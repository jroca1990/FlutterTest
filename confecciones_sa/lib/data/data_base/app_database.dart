import 'dart:async';
import 'package:confeccionessaapp/Utils/encrypt_codec.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  static AppDatabase _singleton;
  Database _db;

  factory AppDatabase() {
    if (_singleton == null) {
      _singleton = AppDatabase._();
    }
    return _singleton;
  }

  AppDatabase._();

  Future<Database> _setupDataBase(String dbName, bool encrypted) async {
    var appDocDirectory = await getApplicationDocumentsDirectory();
    var dbPath = '${appDocDirectory.path}/$dbName.db';
    var dbFactory = databaseFactoryIo;

    var codec;
    if (encrypted) {
      codec = getEncryptSembastCodec(password: 'DYf2eLYEdVTuvGgX');
    }

    return await dbFactory.openDatabase(dbPath, codec: codec);
  }

  Future<Database> get database async {
    if (_db == null) {
      _db = await _setupDataBase('data', false);
    }
    return _db;
  }
}
