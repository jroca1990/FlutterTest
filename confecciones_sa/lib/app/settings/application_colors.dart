import 'package:flutter/material.dart';

class ApplicationColors {
  static ApplicationColors _singleton;

  Color primaryColor;
  Color secondaryColor;

  factory ApplicationColors() {
    if (_singleton == null) {
      _singleton = ApplicationColors._();
    }

    return _singleton;
  }

  ApplicationColors._();
}
