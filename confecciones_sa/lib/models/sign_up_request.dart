class SignUpRequest {
  String uuid;
  String email;
  String password;
  String type;

  SignUpRequest(
      this.uuid,
      this.email,
      this.password,
      this.type
      );

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
    json['uuid'] as String,
    json['email'] as String,
    json['password'] as String,
    json['type'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'uuid': uuid,
    'email': email,
    'password': password,
    'type': type,
  };
}
