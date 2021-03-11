import 'package:confeccionessaapp/di/repository_injector.dart';
import 'package:confeccionessaapp/domain/security_use_case.dart';
import 'package:confeccionessaapp/domain/user_use_case.dart';

class Injector {
  static Injector _singleton;

  factory Injector() {
    if (_singleton == null) {
      _singleton = Injector._();
    }
    return _singleton;
  }

  Injector._();

  SecurityUseCase provideSecurityUseCase() {
    return SecurityUseCaseImpl(
      RepositoryInjector().provideSecurityRepository(),
    );
  }

  UserUseCase provideUserUseCase() {
    return UserUseCaseImpl(
      RepositoryInjector().provideUserRepository(),
    );
  }
}
