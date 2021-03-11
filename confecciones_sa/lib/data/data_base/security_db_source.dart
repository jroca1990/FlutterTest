import 'package:confeccionessaapp/data/data_base/app_database.dart';
import 'package:confeccionessaapp/models/sign_in_request.dart';
import 'package:confeccionessaapp/models/database_store.dart';
import 'package:confeccionessaapp/models/exceptions/app_exception.dart';
import 'package:confeccionessaapp/models/sign_up_request.dart';
import 'package:confeccionessaapp/models/user.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

abstract class SecurityDBSource {
  Future<User> signIn(SignInRequest signInRequest);

  Future signUp(SignUpRequest signUpRequest);

  Future<bool> getUserExists(String email);

  Future<User> getUserByEmail(String email);
}

class SecurityDBSourceImpl  implements SecurityDBSource {
  static SecurityDBSourceImpl _singleton;

  factory SecurityDBSourceImpl() {
    if (_singleton == null) {
      _singleton = SecurityDBSourceImpl._();
    }
    return _singleton;
  }

  SecurityDBSourceImpl._();

  Future<Database> get _db async => await AppDatabase().database;

  final _storeUsers = intMapStoreFactory
      .store(DatabaseStores.USERS.toString());

  @override
  Future<User> signIn(SignInRequest signInRequest) async {
    var user = await getUserByEmail(signInRequest.email);
    if(user == null) {
      throw AppException(ErrorsCode.USER_NOT_EXIST);
    }

    return user;
  }

  @override
  Future signUp(SignUpRequest signUpRequest) async{
    var userExist = await getUserExists(signUpRequest.email);

    if(userExist) {
      throw AppException(ErrorsCode.USER_EXIST);
    }

    signUpRequest.uuid = Uuid().v4();

    return await _storeUsers.add(
        await _db,
        signUpRequest.toJson());
  }

  @override
  Future<bool> getUserExists(String email) async {
    var finder = Finder(filter: Filter.custom((record) {
      var member = User.fromJson(record.value);
      return member.email == email;
    }));

    var result = await _storeUsers.findFirst(await _db, finder: finder);

    return (result == null) ? false : true;
  }

  @override
  Future<User> getUserByEmail(String email) async {
    var finder = Finder(filter: Filter.custom((record) {
      var member = User.fromJson(record.value);
      return member.email == email;
    }));

    var result = await _storeUsers.findFirst(await _db, finder: finder);

    return result != null? User.fromJson(result.value) : null;
  }
}