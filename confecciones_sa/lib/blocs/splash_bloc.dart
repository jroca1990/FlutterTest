import 'package:confeccionessaapp/blocs/provider/bloc.dart';
import 'package:confeccionessaapp/domain/security_use_case.dart';

class SplashBloc extends Bloc {
  final SecurityUseCase _securityUseCase;


  SplashBloc(this._securityUseCase);

  @override
  void dispose() {}
}
