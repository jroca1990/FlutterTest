import 'package:confeccionessaapp/app/settings/app_localizations.dart';
import 'package:confeccionessaapp/app/settings/application_colors.dart';
import 'package:confeccionessaapp/ui/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ConfeccionesApp extends StatelessWidget {
  ConfeccionesApp() {
    ApplicationColors().primaryColor = const Color(0xFF06066e);
    ApplicationColors().secondaryColor = const Color(0xFF118ad5);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en"),
        const Locale("es"),
      ],
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: ApplicationColors().primaryColor,
          brightness: Brightness.light,
        ),
        brightness: Brightness.light,
        fontFamily: 'Open Sans',
        buttonColor: ApplicationColors().secondaryColor,
        appBarTheme: AppBarTheme(color: ApplicationColors().primaryColor),
        cursorColor: ApplicationColors().primaryColor,
      ),
    );
  }
}
