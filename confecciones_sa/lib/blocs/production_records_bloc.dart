import 'package:confeccionessaapp/app/settings/application.dart';
import 'package:confeccionessaapp/blocs/provider/bloc.dart';
import 'package:confeccionessaapp/domain/user_use_case.dart';
import 'package:confeccionessaapp/models/record_production.dart';
import 'package:rxdart/rxdart.dart';

class ProductionRecordsBloc implements Bloc {
  final UserUseCase _userUseCase;

  ProductionRecordsBloc(this._userUseCase);

  final _productionSubject = BehaviorSubject<List<RecordProduction>>();

  ValueStream<List<RecordProduction>> get productionRecords =>
      _productionSubject.stream;

  @override
  void dispose() {
    _productionSubject.close();
  }

  void getAllProductionRecords() async {
    var result = await _userUseCase.getProductionRecordsByUser(Application().applicationUser.uuid);
    _productionSubject.value = result;
  }

  void getAllProductionRecordsForUsers(DateTime time) async {
    var result = await _userUseCase.getProductionRecords(time);
    _productionSubject.value = result;
  }
}