import 'package:confeccionessaapp/blocs/home_bloc.dart';
import 'package:confeccionessaapp/blocs/production_records_bloc.dart';
import 'package:confeccionessaapp/blocs/provider/bloc.dart';
import 'package:confeccionessaapp/blocs/provider/bloc_cache.dart';
import 'package:confeccionessaapp/blocs/roles_bloc.dart';
import 'package:confeccionessaapp/blocs/sign_in_bloc.dart';
import 'package:confeccionessaapp/blocs/splash_bloc.dart';
import 'package:confeccionessaapp/blocs/users_bloc.dart';

class Provider {
  static T of<T extends Bloc>(Function instance) {
    switch (T) {
      case SplashBloc:
        {
          return BlocCache.getBlocInstance("SplashBloc", instance);
        }
      case SignInBloc:
        {
          return BlocCache.getBlocInstance("SignInBloc", instance);
        }
      case HomeBloc:
        {
          return BlocCache.getBlocInstance("HomeBloc", instance);
        }
      case RolesBloc:
        {
          return BlocCache.getBlocInstance("RolesBloc", instance);
        }
      case UsersBloc:
        {
          return BlocCache.getBlocInstance("UsersBloc", instance);
        }
      case ProductionRecordsBloc:
        {
          return BlocCache.getBlocInstance("ProductionRecordsBloc", instance);
        }

    }
    return null;
  }

  static void dispose<T extends Bloc>() {
    switch (T) {
      case SplashBloc:
        {
          BlocCache.dispose("SplashBloc");
          break;
        }
      case SignInBloc:
        {
          BlocCache.dispose("SignInBloc");
          break;
        }
      case HomeBloc:
        {
          BlocCache.dispose("HomeBloc");
          break;
        }
      case RolesBloc:
        {
          BlocCache.dispose("RolesBloc");
          break;
        }
      case UsersBloc:
        {
          BlocCache.dispose("UsersBloc");
          break;
        }
      case ProductionRecordsBloc:
        {
          BlocCache.dispose("ProductionRecordsBloc");
          break;
        }
    }
  }
}
