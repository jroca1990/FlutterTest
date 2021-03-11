import 'dart:async';
import 'package:confeccionessaapp/app/settings/application.dart';
import 'package:confeccionessaapp/blocs/provider/bloc.dart';
import 'package:confeccionessaapp/domain/user_use_case.dart';
import 'package:confeccionessaapp/models/record_production.dart';
import 'package:confeccionessaapp/models/time_schedule.dart';
import 'package:confeccionessaapp/models/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class UsersBloc implements Bloc {
  final UserUseCase _userUseCase;

  UsersBloc(this._userUseCase);

  final _usersSubject = BehaviorSubject<List<User>>();

  ValueStream<List<User>> get users =>
      _usersSubject.stream;

  @override
  void dispose() {
    _usersSubject.close();
  }

  void getAllUsers() async {
    var result = await _userUseCase.getAllUsers();
    _usersSubject.value = result;
  }

  Future addRecordProduction(int qty, String imagePath) async{
    var recordProduction = RecordProduction(time: DateTime.now(), qty: qty, user: Application().applicationUser, uuid: Uuid().v4(), imagePath: imagePath);

    return await _userUseCase.addRecordProduction(recordProduction).then((result) {
      return result;
    });
  }

  Future addSchedule(DateTime startTime, DateTime endTime) async {
    TimeSchedule timeSchedule = TimeSchedule(Uuid().v4(), startTime, endTime);
    return await _userUseCase.addSchedule(timeSchedule);
  }

  Future editSchedule(TimeSchedule timeSchedule) async {
    return await _userUseCase.editSchedule(timeSchedule);
  }

  Future <TimeSchedule> getDefaultSchedule() async {
    return await _userUseCase.getDefaultSchedule();
  }
}