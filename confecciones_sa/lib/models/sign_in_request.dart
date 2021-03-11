class SignInRequest {
  String email;
  String password;

  SignInRequest(
      this.email,
      this.password,
      );

  factory SignInRequest.fromJson(Map<String, dynamic> json) =>
      SignInRequest(
        json['username'] as String,
        json['password'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'username': email,
    'password': password,
  };
}
