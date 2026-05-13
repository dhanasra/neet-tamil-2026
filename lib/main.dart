import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/localization/localization_service.dart';
import 'core/storage/storage_service.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await StorageService.init();

  runApp(
    EasyLocalization(
      supportedLocales: LocalizationService.supportedLocales,
      path: LocalizationService.path,
      fallbackLocale: LocalizationService.fallbackLocale,
      child: const App(),
    ),
  );
}
