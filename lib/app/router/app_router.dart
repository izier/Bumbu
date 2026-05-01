import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/landing_page.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../shell/app_shell.dart';
import 'route_names.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  // ✅ Do NOT watch authStateProvider here — that would recreate the entire
  // GoRouter on every auth change, leaving signInStateProvider with stale
  // state on the next session. The notifier handles refreshes instead.
  final routerNotifier = _AuthRouterNotifier(ref);

  return GoRouter(
    initialLocation: RouteNames.splash,
    refreshListenable: routerNotifier,

    redirect: (context, state) {
      // ✅ Read (not watch) inside redirect so no rebuild is triggered here.
      final user = ref.read(authStateProvider);
      final isLoggedIn = user != null;
      final location = state.matchedLocation;

      final isSplash  = location == RouteNames.splash;
      final isLanding = location == RouteNames.landing;
      final isAuth    = location.startsWith(RouteNames.auth);

      // ── Not logged in ────────────────────────────────────────────────────
      if (!isLoggedIn) {
        if (isLanding || isAuth) return null;
        return RouteNames.landing;
      }

      // ── Logged in ────────────────────────────────────────────────────────
      if (isSplash || isLanding || isAuth) return RouteNames.home;

      return null;
    },

    routes: [
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
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => const AppShell(),
      ),
      GoRoute(
        path: RouteNames.feed,
        builder: (context, state) => const FeedPage(),
      ),
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
      GoRoute(
        path: RouteNames.pantry,
        builder: (context, state) => const PantryPage(),
      ),
      GoRoute(
        path: RouteNames.shopping,
        builder: (context, state) => const ShoppingPage(),
      ),
      GoRoute(
        path: RouteNames.search,
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: RouteNames.profile,
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
});

// Bridges Riverpod → GoRouter's ChangeNotifier-based refresh mechanism.
class _AuthRouterNotifier extends ChangeNotifier {
  _AuthRouterNotifier(Ref ref) {
    ref.listen(authStateProvider, (_, __) => notifyListeners());
  }
}

// --- TEMP PLACEHOLDERS ---

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Feed')));
}

class RecipeDetailPage extends StatelessWidget {
  final String id;
  const RecipeDetailPage({super.key, required this.id});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Recipe: $id')));
}

class CookingPage extends StatelessWidget {
  const CookingPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Cooking')));
}

class PantryPage extends StatelessWidget {
  const PantryPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Pantry')));
}

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Shopping')));
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Search')));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Profile')));
}