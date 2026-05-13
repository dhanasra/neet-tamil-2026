import 'package:flutter/material.dart';

class LocalizationService {
  static const String path = 'assets/translations';
  static const Locale fallbackLocale = Locale('en', 'US');
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    // TODO: add more locales here
  ];
}
