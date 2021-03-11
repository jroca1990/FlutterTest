import 'package:confeccionessaapp/data/data_base/app_database.dart';
import 'package:confeccionessaapp/models/record_production.dart';
import 'package:confeccionessaapp/models/rol.dart';
import 'package:confeccionessaapp/models/database_store.dart';
import 'package:confeccionessaapp/models/time_schedule.dart';
import 'package:confeccionessaapp/models/user.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

abstract class UserDBSource {
  Future addRol(Rol rol);
  Future updateRol(Rol rol);
  Future deleteRol(Rol rol);
  Future <List<Rol>> getAllRoles();
  Future <List<User>>getAllUsers();
  Future assignRol(User user);
  Future addRecordProduction(RecordProduction recordProduction);
  Future<List<RecordProduction>> getProductionRecordsByUser(String userId);
  Future<List<RecordProduction>> getProductionRecords(DateTime time);
  Future addSchedule(TimeSchedule timeSchedule);
  Future editSchedule(TimeSchedule timeSchedule);
  Future <TimeSchedule> getDefaultSchedule();
  }

class UserDBSourceImpl  implements UserDBSource {
  static UserDBSourceImpl _singleton;

  factory UserDBSourceImpl() {
    if (_singleton == null) {
      _singleton = UserDBSourceImpl._();
    }
    return _singleton;
  }

  UserDBSourceImpl._();

  Future<Database> get _db async => await AppDatabase().database;

  final _storeRoles = intMapStoreFactory
      .store(DatabaseStores.ROLES.toString());

  final _storeUsers = intMapStoreFactory
      .store(DatabaseStores.USERS.toString());

  final _storeRecordProduction = intMapStoreFactory
      .store(DatabaseStores.RECORD_PRODUCTION.toString());

  final _storeTimeSchedule= intMapStoreFactory
      .store(DatabaseStores.TIME_SCHEDULE.toString());

  @override
  Future addRol(Rol rol) async{
    rol.uuid = Uuid().v4();

    return await _storeRoles.add(
        await _db,
        rol.toJson());
  }

  @override
  Future updateRol(Rol rol) async{
    var finder = Finder(filter: Filter.custom((record) {
      var finderRol = Rol.fromJson(record.value);
      return finderRol.uuid == rol.uuid;
    }));

    return await _storeRoles.update(
      await _db,
      rol.toJson(),
      finder: finder,
    );
  }

  @override
  Future deleteRol(Rol rol) async{
    var finder = Finder(filter: Filter.custom((record) {
      var finderRol = Rol.fromJson(record.value);
      return finderRol.uuid == rol.uuid;
    }));

    return await _storeRoles.delete(
      await _db,
      finder: finder,
    );
  }

  @override
  Future <List<Rol>> getAllRoles() async {
    final records = await _storeRoles.find(await _db);
    return records.map((record) {
      return Rol.fromJson(record.value);
    }).toList();
  }

  @override
  Future<List<User>> getAllUsers() async {
    var finder = Finder(filter: Filter.custom((record) {
      var finderUser = User.fromJson(record.value);
      return finderUser.type ==  'employee';
    }));

    final records = await _storeUsers.find(await _db,
        finder: finder);
    return records.map((record) {
      return User.fromJson(record.value);
    }).toList();
  }

  @override
  Future assignRol(User user) async {
    var finder = Finder(filter: Filter.custom((record) {
      var finderUser = User.fromJson(record.value);
      return finderUser.uuid == user.uuid;
    }));

    return await _storeUsers.update(
      await _db,
      user.toJson(),
      finder: finder,
    );
  }

  @override
  Future addRecordProduction(RecordProduction recordProduction) async {
    return await _storeRecordProduction.add(
        await _db,
        recordProduction.toJson());
  }

  @override
  Future<List<RecordProduction>> getProductionRecordsByUser(String userId) async{
    var finder = Finder(filter: Filter.custom((record) {
      var finderRecordProduction = RecordProduction.fromJson(record.value);
      return finderRecordProduction.user.uuid ==  userId &&
          finderRecordProduction.time != null &&
          finderRecordProduction.user != null &&
          finderRecordProduction.user.rol != null;
    }),sortOrders: [SortOrder('time', false)]);

    final records = await _storeRecordProduction.find(await _db, finder: finder);
    return records.map((record) {
      return RecordProduction.fromJson(record.value);
    }).toList();
  }

  @override
  Future<List<RecordProduction>> getProductionRecords(DateTime time) async {

    var finder = Finder(filter: Filter.custom((record) {
      var finderRecordProduction = RecordProduction.fromJson(record.value);
      return finderRecordProduction.time != null &&
          finderRecordProduction.user != null &&
          finderRecordProduction.user.rol != null &&
          finderRecordProduction.time.year == time.year &&
          finderRecordProduction.time.month == time.month &&
          finderRecordProduction.time.day == time.day
      ;
    }), sortOrders: [SortOrder('time', false)]);

    final records = await _storeRecordProduction.find(await _db, finder: finder);

    return records.map((record) {
      return RecordProduction.fromJson(record.value);
    }).toList();
  }

  @override
  Future addSchedule(TimeSchedule timeSchedule) async {
    return await _storeTimeSchedule.add(
        await _db,
        timeSchedule.toJson());
  }

  @override
  Future editSchedule(TimeSchedule timeSchedule) async {
    var finder = Finder(filter: Filter.custom((record) {
      var finderTimeSchedule = TimeSchedule.fromJson(record.value);
      return finderTimeSchedule.uuid == timeSchedule.uuid;
    }));

    return await _storeTimeSchedule.update(
      await _db,
      timeSchedule.toJson(),
      finder: finder,
    );
  }

  @override
  Future <TimeSchedule> getDefaultSchedule() async {
    final records = await _storeTimeSchedule.find(await _db);
    return records.map((record) {
      return TimeSchedule.fromJson(record.value);
    }).toList().first;
  }
}