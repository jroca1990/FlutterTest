class TimeSchedule {
  String uuid;
  DateTime startTime;
  DateTime endTime;

  TimeSchedule(
      this.uuid,
      this.startTime,
      this.endTime
      );

  factory TimeSchedule.fromJson(Map<String, dynamic> json) => TimeSchedule(
    json['uuid'] as String,
    json['startTime'] == null
        ? null
        : json['startTime'] is String
        ? DateTime.parse(json['startTime'] as String)
        : DateTime.fromMillisecondsSinceEpoch(json['startTime'] as int),
    json['endTime'] == null
        ? null
        : json['endTime'] is String
        ? DateTime.parse(json['endTime'] as String)
        : DateTime.fromMillisecondsSinceEpoch(json['endTime'] as int),
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'uuid': uuid,
    'startTime': startTime?.toIso8601String(),
    'endTime': endTime?.toIso8601String(),
  };
}
