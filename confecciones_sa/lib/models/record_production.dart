import 'package:confeccionessaapp/models/user.dart';

class RecordProduction {
  String uuid;
  DateTime time;
  int qty;
  User user;
  String imagePath;

  bool completed;
  String additional;
  String missing;

  RecordProduction({
    this.uuid,
    this.time,
    this.qty,
    this.user,
    this.imagePath,
  });

  factory RecordProduction.fromJson(Map<String, dynamic> json) =>
      RecordProduction(
        uuid: json['uuid'] as String,
        time: json['time'] == null
            ? null
            : json['time'] is String
            ? DateTime.parse(json['time'] as String)
            : DateTime.fromMillisecondsSinceEpoch(json['time'] as int),
        qty: json['qty'] as int,
        user:  json['user'] != null?  User.fromJson(json['user']) : null,
        imagePath:  json['imagePath'] != null?  json['imagePath']: '',
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'uuid': uuid,
    'time': time?.toIso8601String(),
    'qty': qty,
    'user': user != null ? user.toJson() : null,
    'imagePath': imagePath,
  };
}
