import 'package:go_router/go_router.dart';
import 'package:tdd_practice/src/auth/presentation/pages/all_user_screen.dart';
import 'package:tdd_practice/src/auth/presentation/pages/home_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/users',
      builder: (context, state) => const AllScreenUsers(),
    ),
  ],
);
