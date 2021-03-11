import 'package:confeccionessaapp/app/settings/application_assets.dart';
import 'package:confeccionessaapp/blocs/splash_bloc.dart';
import 'package:confeccionessaapp/di/injector.dart';
import 'package:confeccionessaapp/ui/base_state.dart';
import 'package:confeccionessaapp/ui/sign_in_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage, SplashBloc> {

  @override
  SplashBloc getBlocInstance() {
    return SplashBloc(Injector().provideSecurityUseCase());
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SignInPage())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildWaitingScreen();
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Center(
        child:
        Image.asset(ApplicationAssets.logo),
      ),
    );
  }
}
