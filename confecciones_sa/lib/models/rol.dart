class Rol {
  String uuid;
  String name;
  int production;

  Rol({
    this.uuid,
    this.name,
    this.production,
  });

  factory Rol.fromJson(Map<String, dynamic> json) =>
      Rol(
        uuid: json['uuid'] as String,
        name: json['name'] as String,
        production: json['production'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'uuid': uuid,
    'name': name,
    'production': production,
  };
}
