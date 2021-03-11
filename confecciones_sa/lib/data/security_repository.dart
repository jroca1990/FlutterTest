import 'package:confeccionessaapp/data/data_base/security_db_source.dart';
import 'package:confeccionessaapp/models/sign_in_request.dart';
import 'package:confeccionessaapp/models/sign_up_request.dart';
import 'package:confeccionessaapp/models/user.dart';

abstract class SecurityRepository {
  Future<User> signIn(SignInRequest authenticationRequest);

  Future signUp(SignUpRequest signUpRequest);

  Future<User> getUserByEmail(String email);
}

class SecurityRepositoryImpl implements SecurityRepository {
  final SecurityDBSource _dbSource;

  SecurityRepositoryImpl(this._dbSource);

  @override
  Future<User> signIn(SignInRequest signInRequest) async {
    return await _dbSource.signIn(signInRequest).then((result) {
      return result;
    });
  }

  @override
  Future signUp(SignUpRequest signUpRequest) async {
     return await _dbSource.signUp(signUpRequest).then((result) {
       return result;
     });
  }

  @override
  Future<User> getUserByEmail(String email) async {
    return await _dbSource.getUserByEmail(email).then((result) {
      return result;
    });
  }
}