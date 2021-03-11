import 'package:confeccionessaapp/data/data_base/user_db_source.dart';
import 'package:confeccionessaapp/models/record_production.dart';
import 'package:confeccionessaapp/models/rol.dart';
import 'package:confeccionessaapp/models/time_schedule.dart';
import 'package:confeccionessaapp/models/user.dart';

abstract class UserRepository {
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

class UserRepositoryImpl implements UserRepository {
  final UserDBSource _dbSource;

  UserRepositoryImpl(this._dbSource);

  @override
  Future addRol(Rol rol) async {
    return await _dbSource.addRol(rol);
  }

  @override
  Future updateRol(Rol rol) async{
    return await _dbSource.updateRol(rol);
  }

  @override
  Future<List<Rol>> getAllRoles() async {
    return await _dbSource.getAllRoles();
  }

  @override
  Future deleteRol(Rol rol) async {
    return await _dbSource.deleteRol(rol);
  }

  @override
  Future<List<User>> getAllUsers() async{
    return await _dbSource.getAllUsers();
  }

  @override
  Future assignRol(User user) async {
    return await _dbSource.assignRol(user);
  }

  @override
  Future addRecordProduction(RecordProduction recordProduction) async {
    return await _dbSource.addRecordProduction(recordProduction);
  }

  @override
  Future<List<RecordProduction>> getProductionRecordsByUser(String userId) async{
    return await _dbSource.getProductionRecordsByUser(userId);
  }

  @override
  Future<List<RecordProduction>> getProductionRecords(DateTime time) async {
    return await _dbSource.getProductionRecords(time);
  }

  @override
  Future addSchedule(TimeSchedule timeSchedule) async {
    return await _dbSource.addSchedule(timeSchedule);
  }

  @override
  Future editSchedule(TimeSchedule timeSchedule) async {
    return await _dbSource.editSchedule(timeSchedule);
  }

  @override
  Future <TimeSchedule> getDefaultSchedule() async {
    return await _dbSource.getDefaultSchedule();
  }
}