import 'dart:async';
import 'package:confeccionessaapp/blocs/provider/bloc.dart';
import 'package:confeccionessaapp/domain/user_use_case.dart';
import 'package:confeccionessaapp/models/rol.dart';
import 'package:confeccionessaapp/models/user.dart';
import 'package:rxdart/rxdart.dart';

class RolesBloc implements Bloc {
  final UserUseCase _userUseCase;

  RolesBloc(this._userUseCase);

  final _rolesSubject = BehaviorSubject<List<Rol>>();

  ValueStream<List<Rol>> get roles =>
      _rolesSubject.stream;

  @override
  void dispose() {
    _rolesSubject.close();
  }


  Future addRol(String name, String productionQty) async {
    return await _userUseCase.addRol( Rol(name: name, production: int.parse(productionQty))).then((result) {
      return result;
    });
  }

  Future updateRol(String name, String productionQty) async {
    return await _userUseCase.updateRol( Rol(name: name, production: int.parse(productionQty))).then((result) {
      return result;
    });
  }

  Future deleteRol(String rolUuid) async {
    return await _userUseCase.deleteRol( Rol(uuid: rolUuid)).then((result) {
      return result;
    });
  }

  void getAllRoles() async {
    var result = await _userUseCase.getAllRoles();
    _rolesSubject.value = result;
  }

  Future assignRol(User user) async{
    return await _userUseCase.assignRol(user).then((result) {
      return result;
    });
  }
}