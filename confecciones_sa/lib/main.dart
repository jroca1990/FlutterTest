import 'dart:async';
import 'package:confeccionessaapp/app/confecciones_app.dart';
import 'package:flutter/material.dart';

void main() async {
  runZoned<Future<void>>(() async {
    runApp(ConfeccionesApp());
  });
}

