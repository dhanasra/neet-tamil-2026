import 'package:go_router/go_router.dart';

import 'app_routes.dart';
import '../pages/home/home_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.home,

    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
