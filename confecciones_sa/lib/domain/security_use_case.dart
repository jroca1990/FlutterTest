import 'package:confeccionessaapp/data/security_repository.dart';
import 'package:confeccionessaapp/models/exceptions/app_exception.dart';
import 'package:confeccionessaapp/models/sign_in_request.dart';
import 'package:confeccionessaapp/models/sign_up_request.dart';
import 'package:confeccionessaapp/models/user.dart';
import 'package:encrypt/encrypt.dart' as keyEncrypt;

abstract class SecurityUseCase {
  Future<User> signIn(
      SignInRequest authenticationRequest);

  Future signUp(
      SignUpRequest signUpRequest);

  Future<User> getUserByEmail(String email);
}

class SecurityUseCaseImpl implements SecurityUseCase {
  final SecurityRepository _repository;

  SecurityUseCaseImpl(this._repository);

  @override
  Future<User> signIn(SignInRequest authenticationRequest) async {
    return await _repository.signIn(authenticationRequest).then((result) {
      var authenticated = getIsAuthenticatedUser(authenticationRequest, result);

      if(!authenticated) {
        throw AppException(ErrorsCode.USER_INVALID_PASSWORD);
      } else {
        result.authenticated = getIsAuthenticatedUser(authenticationRequest, result);
      }
      return result;
    });
  }

  bool getIsAuthenticatedUser(SignInRequest authenticationRequest, User user) {
    final plainText = authenticationRequest.password;
    final key = keyEncrypt.Key.fromUtf8('fJTuyuMBruK9xFjaUad5Z5BDCDf4B87Y');
    final iv = keyEncrypt.IV.fromLength(16);

    final encrypter = keyEncrypt.Encrypter(keyEncrypt.AES(key));

    final encryptedRequest = encrypter.encrypt(plainText, iv: iv);

    return encryptedRequest.base64 == user.password ? true :false;
  }

  @override
  Future<User> getUserByEmail(String email) {
    return _repository.getUserByEmail(email).then((result) {
      return result;
    });
  }

  @override
  Future signUp(SignUpRequest signUpRequest) async {
    final plainText = signUpRequest.password;
    final key = keyEncrypt.Key.fromUtf8('fJTuyuMBruK9xFjaUad5Z5BDCDf4B87Y');
    final iv = keyEncrypt.IV.fromLength(16);

    final encrypter = keyEncrypt.Encrypter(keyEncrypt.AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);

    signUpRequest.password = encrypted.base64;

    return await _repository.signUp(signUpRequest).then((result) {
      return result;
    });
  }
}