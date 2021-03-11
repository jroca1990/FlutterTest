import 'package:confeccionessaapp/data/data_base/security_db_source.dart';
import 'package:confeccionessaapp/data/data_base/user_db_source.dart';

class DataSourceInjector {
  static DataSourceInjector _singleton;

  factory DataSourceInjector() {
    if (_singleton == null) {
      _singleton = DataSourceInjector._();
    }
    return _singleton;
  }

  DataSourceInjector._() {

  }

  SecurityDBSource provideSecurityDBSource() {
    return SecurityDBSourceImpl();
  }

  UserDBSource provideUserDBSource() {
    return UserDBSourceImpl();
  }
}
