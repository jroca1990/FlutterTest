import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    Intl.defaultLocale = locale.languageCode;
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Confecciones S.A,',
      'admin': 'Admin',
      'signIn': 'Sign In',
      'signUp': 'Sign Up',
      'userName' : 'Username',
      'password' : 'Password',
      'createAccount': 'Create an account',
      'haveAccount': 'Have an account? Sign in',
      'emailRegexInvalid': 'You must enter a valid email.',
      'signUpAdmin' : 'Sign Up as a admin',
      'userExist' : 'User already exist.',
      'baseErrorMessage':'An error occurred, try again!',
      'employee': 'Employee',
      'roles' : 'Roles',
      'userNotExist' : "User doesn't exist",
      'invalidPassword' : 'Invalid password',
      'rolName' : 'Rol name',
      'rolMaxProduction' : 'Maximum production',
      'assignRol' : 'Assign role',
      'recordProduction' : 'Add production',
      'qty' : 'Quantity',
      'productionRecords' : 'Production records',
      'noRolAssigned' : 'You have no assigned role.',
      'message' : 'Message',
      'productionReport' : 'Production report',
      'productionLimit' : 'Production limit',
      'produced' : 'Produced',
      'completed' : 'Completed',
      'additional' : 'Additional',
      'missing' : 'Missing',
      'yes' : 'Yes',
      'no' : 'No',
      'selectDate' : 'Select date',
      'rememberRecordProduction':'remember to record the production!',
      'alert' : 'Alert',
      'alertEmptyField' : 'You must fill all fields.',
      'time_schedule' : 'Time schedule',
      'select' : 'Select',
      'startTimeSchedule' : 'Check in time',
      'endTimeSchedule' : 'Check out time',
      'outTimeSchedule' : 'Cannot record production outside business hours',
    },
    'es': {
      'appTitle': 'Confecciones S.A,',
      'admin': 'Administrador',
      'signIn': 'Ingresar',
      'signUp': 'Registrarse',
      'userName' : 'Usuario',
      'password' : 'Contraseña',
      'createAccount': 'Crear una cuenta',
      'haveAccount': '¿Tienes una cuenta? Ingresar',
      'emailRegexInvalid': 'Debes ingresar un correo válido.',
      'signUpAdmin' : 'Registrarse como administrador',
      'userExist' : 'El usuario ya existe',
      'baseErrorMessage':'se produjo un error, intente nuevamente!',
      'employee': 'Empleado',
      'roles' : 'Roles',
      'userNotExist' : 'El usuario no existe',
      'invalidPassword' : 'Contraseña invalida',
      'rolName' : 'Nombre del rol',
      'rolMaxProduction' : 'Producción máxima',
      'assignRol' : 'Asignar rol',
      'recordProduction' : 'Registrar producido',
      'qty' : 'Cantidad',
      'productionRecords' : 'Registros de producción',
      'noRolAssigned' : 'No tiene rol asignado.',
      'message' : 'Mensaje',
      'productionReport' : 'Reporte de producción',
      'productionLimit' : 'Limite de producción',
      'produced' : 'Producido',
      'completed' : 'Cumplido',
      'additional' : 'adicional',
      'missing' : 'falta',
      'yes' : 'Si',
      'no' : 'No',
      'selectDate' : 'Seleccionar fecha',
      'rememberRecordProduction' : 'recuerda registrar la produccion!',
      'alert' : 'Alerta',
      'alertEmptyField' : 'Debes llenar todos los campos.',
      'time_schedule' : 'Horario',
      'select' : 'Seleccionar',
      'startTimeSchedule' : 'Hora de entrada',
      'endTimeSchedule' : 'Hora de salida',
      'outTimeSchedule' : 'No puede registrar produccion fuera de las horas laborales',
    },
  };

  String getText(String key) {
    //locale.languageCode
    var text = _localizedValues.containsKey(locale.languageCode)  ?
    _localizedValues['es'][key] :
    _localizedValues['es'][key];//_localizedValues[locale.languageCode][key];

    return text != null ? text : "default";
  }

  String get titleApp {
    return getText('appTitle');
  }

  String get admin {
    return getText('admin');
  }

  String get signIn {
    return getText('signIn');
  }

  String get signUp {
    return getText('signUp');
  }

  String get userName {
    return getText('userName');
  }

  String get password {
    return getText('password');
  }

  String get createAccount {
    return getText('createAccount');
  }

  String get haveAccount {
    return getText('haveAccount');
  }

  String get emailRegexInvalid {
    return getText('emailRegexInvalid');
  }

  String get signUpAdmin {
    return getText('signUpAdmin');
  }

  String get userExist {
    return getText('userExist');
  }

  String get baseErrorMessage {
    return getText('baseErrorMessage');
  }

  String get employee {
    return getText('employee');
  }

  String get roles {
    return getText('roles');
  }

  String get userNotExist {
    return getText('userNotExist');
  }

  String get invalidPassword {
    return getText('invalidPassword');
  }

  String get rolName {
    return getText('rolName');
  }

  String get rolMaxProduction {
    return getText('rolMaxProduction');
  }

  String get assignRol {
    return getText('assignRol');
  }

  String get recordProduction {
    return getText('recordProduction');
  }

  String get qty {
    return getText('qty');
  }

  String get productionRecords {
    return getText('productionRecords');
  }

  String get noRolAssigned {
    return getText('noRolAssigned');
  }

  String get message {
    return getText('message');
  }

  String get productionReport {
    return getText('productionReport');
  }

  String get productionLimit {
    return getText('productionLimit');
  }

  String get produced {
    return getText('produced');
  }

  String get completed {
    return getText('completed');
  }

  String get additional {
    return getText('additional');
  }

  String get missing {
    return getText('missing');
  }

  String get yes {
    return getText('yes');
  }

  String get no {
    return getText('no');
  }

  String get selectDate {
    return getText('selectDate');
  }

  String get rememberRecordProduction {
    return getText('rememberRecordProduction');
  }

  String get alert {
    return getText('alert');
  }

  String get alertEmptyField {
    return getText('alertEmptyField');
  }

  String get timeSchedule {
    return getText('time_schedule');
  }

  String get select {
    return getText('select');
  }

  String get startTimeSchedule {
    return getText('startTimeSchedule');
  }

  String get endTimeSchedule {
    return getText('endTimeSchedule');
  }

  String get outTimeSchedule {
    return getText('outTimeSchedule');
  }
}
