import 'package:confeccionessaapp/data/user_repository.dart';
import 'package:confeccionessaapp/models/record_production.dart';
import 'package:confeccionessaapp/models/rol.dart';
import 'package:confeccionessaapp/models/time_schedule.dart';
import 'package:confeccionessaapp/models/user.dart';

abstract class UserUseCase {
  Future addRol(Rol rol);
  Future updateRol(Rol rol);
  Future deleteRol(Rol rol);
  Future<List<Rol>> getAllRoles();
  Future <List<User>>getAllUsers();
  Future assignRol(User user);
  Future addRecordProduction(RecordProduction recordProduction);
  Future<List<RecordProduction>> getProductionRecordsByUser(String userId);
  Future<List<RecordProduction>> getProductionRecords(DateTime time);
  Future addSchedule(TimeSchedule timeSchedule);
  Future editSchedule(TimeSchedule timeSchedule);
  Future <TimeSchedule> getDefaultSchedule();
  }

class UserUseCaseImpl implements UserUseCase {
  final UserRepository _repository;

  UserUseCaseImpl(this._repository);

  @override
  Future addRol(Rol rol) async {
    return await _repository.addRol(rol);
  }

  @override
  Future updateRol(Rol rol) async{
    return await _repository.updateRol(rol);
  }

  @override
  Future<List<Rol>> getAllRoles() async{
    return await _repository.getAllRoles();
  }

  @override
  Future deleteRol(Rol rol) async {
    return await _repository.deleteRol(rol);
  }

  @override
  Future<List<User>> getAllUsers() async{
    return await _repository.getAllUsers();
  }

  @override
  Future assignRol(User user) async {
    return await _repository.assignRol(user);
  }

  @override
  Future addRecordProduction(RecordProduction recordProduction) async {
    return await _repository.addRecordProduction(recordProduction);
  }

  @override
  Future<List<RecordProduction>> getProductionRecordsByUser(String userId) async{
    return await _repository.getProductionRecordsByUser(userId);
  }

  @override
  Future<List<RecordProduction>> getProductionRecords(DateTime time) async {
    var list =  await _repository.getProductionRecords(time);
    var finalList = List<RecordProduction>();

    for(RecordProduction item in list) {
      var exist = _verifyExistRecord(finalList, item);
      if(!exist) {
        finalList.add(item);
      } else {
        _setRecordExist(finalList, item);
      }
    }

    for(RecordProduction item in finalList) {
      if (item.qty < item.user.rol.production) {
        item.completed = false;
        item.additional = '0';
        int missing = item.user.rol.production - item.qty;

        item.missing = missing.toString();
      } else {
        item.completed = true;
      }

      if (item.qty > item.user.rol.production) {
        int additional = item.qty - item.user.rol.production;
        item.additional = additional.toString();
        item.missing = '0';
      }
    }

    return finalList;
  }

  @override
  Future addSchedule(TimeSchedule timeSchedule) async{
    return await _repository.addSchedule(timeSchedule);
  }

  @override
  Future editSchedule(TimeSchedule timeSchedule) async {
    return await _repository.editSchedule(timeSchedule);
  }

  @override
  Future <TimeSchedule> getDefaultSchedule() async {
    return await _repository.getDefaultSchedule();
  }

  bool _verifyExistRecord(List<RecordProduction> finalList, RecordProduction record) {
    bool result = false;

    for(RecordProduction item in finalList) {
      if (item.user.rol.name == record.user.rol.name && item.user.uuid == record.user.uuid) {
        result = true;
        break;
      }
    }
    return result;
  }

  void _setRecordExist(List<RecordProduction> finalList, RecordProduction record) {
    for (RecordProduction item in finalList) {
      if (item.user.rol.name == record.user.rol.name &&
          item.user.uuid == record.user.uuid) {
        item.qty = item.qty + record.qty;
        break;
      }
    }
  }
}

