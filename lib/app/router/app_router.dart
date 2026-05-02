import 'package:bumbu/features/kitchen/presentation/pages/activity_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/auth/presentation/pages/landing_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/cooking/presentation/pages/cooking_mode_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/pantry/presentation/pages/pantry_page.dart';
import '../../features/recipe/presentation/pages/recipe_detail_page.dart';
import '../../features/shopping/presentation/pages/shopping_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/activity/presentation/pages/activity_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';

import '../shell/app_shell.dart';
import 'route_names.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final routerNotifier = _AuthRouterNotifier(ref);

  final router = GoRouter(
    initialLocation: RouteNames.splash,
    refreshListenable: routerNotifier,
    redirect: (context, state) {
      final user = ref.read(authStateProvider);
      final isLoggedIn = user != null;
      final location = state.matchedLocation;

      final isSplash = location == RouteNames.splash;
      final isLanding = location == RouteNames.landing;
      final isAuth = location.startsWith(RouteNames.auth);

      if (!isLoggedIn) {
        if (isLanding || isAuth) return null;
        return RouteNames.landing;
      }

      if (isSplash || isLanding || isAuth) {
        return RouteNames.home;
      }

      return null;
    },
    routes: [
      // ───────── CORE ─────────
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RouteNames.landing,
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: RouteNames.auth,
        builder: (context, state) => const AuthPage(),
      ),

      // ───────── SHELL ─────────
      ShellRoute(
        builder: (context, state, child) => AppShell(),
        routes: [
          GoRoute(
            path: RouteNames.home,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: RouteNames.kitchen,
            builder: (context, state) => const KitchenPage(),
            routes: [
              GoRoute(
                path: 'pantry',
                builder: (context, state) => const PantryPage(),
              ),
              GoRoute(
                path: 'shopping',
                builder: (context, state) => const ShoppingPage(),
              ),
            ],
          ),
          GoRoute(
            path: RouteNames.activity,
            builder: (context, state) => const ActivityPage(),
          ),
          GoRoute(
            path: RouteNames.chat,
            builder: (context, state) => const ChatPage(),
          ),
          GoRoute(
            path: RouteNames.profile,
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),

      // ───────── DEEP SCREENS ─────────
      GoRoute(
        path: '${RouteNames.recipeDetail}/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return RecipeDetailPage(id: id);
        },
      ),
      GoRoute(
        path: RouteNames.cooking,
        builder: (context, state) => const CookingPage(),
      ),
    ],
  );

  ref.onDispose(routerNotifier.dispose);
  ref.onDispose(router.dispose);

  return router;
});

class _AuthRouterNotifier extends ChangeNotifier {
  _AuthRouterNotifier(Ref ref) {
    ref.listen(authStateProvider, (_, _) => notifyListeners());
  }
}
