import 'package:confeccionessaapp/blocs/provider/bloc.dart';
import 'package:confeccionessaapp/domain/security_use_case.dart';
import 'package:confeccionessaapp/models/sign_in_request.dart';
import 'package:confeccionessaapp/models/sign_up_request.dart';
import 'package:confeccionessaapp/models/user.dart';

class SignInBloc extends Bloc {
  final SecurityUseCase _securityUseCase;

  SignInBloc(this._securityUseCase);

  @override
  void dispose() {}

  Future<User> signIn(String user, String password) async {
    var authenticationRequest = SignInRequest(user, password);

    return await _securityUseCase.signIn(authenticationRequest).then((result) {
      return result;
    });
  }

  Future signUp(String user, String password,  bool _asAdmin) async {
    var signUpRequest = SignUpRequest('',user, password, _asAdmin ? 'admin':'employee');//app_ambassador_user

    return await _securityUseCase.signUp(signUpRequest).then((result) {
      return result;
    });
  }

  Future<User> getAuthenticationInfo(String email) async{
    return await _securityUseCase.getUserByEmail(email).then((result) {
      return result;
    });
  }
}