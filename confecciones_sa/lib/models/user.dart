import 'package:confeccionessaapp/models/rol.dart';

class User {
  String uuid;
  String email;
  String password;
  String type;
  bool authenticated;
  Rol rol;

  User({
    this.uuid,
    this.email,
    this.password,
    this.type,
    this.rol,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      User(
        uuid: json['uuid'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
        type: json['type'] as String,
        rol:  json['rol'] != null?  Rol.fromJson(json['rol']) : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'uuid': uuid,
    'email': email,
    'password': password,
    'type': type,
    'rol': rol != null ? rol.toJson() : null,
  };
}
