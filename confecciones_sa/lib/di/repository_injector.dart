import 'package:confeccionessaapp/data/security_repository.dart';
import 'package:confeccionessaapp/data/user_repository.dart';
import 'package:confeccionessaapp/di/data_source_injector.dart';

class RepositoryInjector {
  static RepositoryInjector _singleton;

  factory RepositoryInjector() {
    if (_singleton == null) {
      _singleton = RepositoryInjector._();
    }
    return _singleton;
  }

  RepositoryInjector._();

  SecurityRepository provideSecurityRepository() {
    return SecurityRepositoryImpl(
        DataSourceInjector().provideSecurityDBSource()
    );
  }

  UserRepository provideUserRepository() {
    return UserRepositoryImpl(
        DataSourceInjector().provideUserDBSource()
    );
  }
}
