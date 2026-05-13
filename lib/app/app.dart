import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/bloc/theme_cubit.dart';
import '../routes/app_pages.dart';
import '../routes/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NEET Tamil 2026',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            onGenerateRoute: AppPages.onGenerateRoute,
            initialRoute: AppRoutes.home,
          );
        },
      ),
    );
  }
}
