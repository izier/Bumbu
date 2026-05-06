import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:bumbu/features/auth/presentation/pages/auth_page.dart';
import 'package:bumbu/features/auth/presentation/pages/landing_page.dart';
import 'package:bumbu/features/auth/presentation/providers/auth_provider.dart';
import 'package:bumbu/features/cooking/presentation/pages/cooking_mode_page.dart';
import 'package:bumbu/features/home/presentation/pages/home_page.dart';
import 'package:bumbu/features/pantry/presentation/pages/pantry_page.dart';
import 'package:bumbu/features/recipe/domain/entities/recipe.dart';
import 'package:bumbu/features/recipe/presentation/pages/recipe_detail_page.dart';
import 'package:bumbu/features/recipe/presentation/pages/recipe_editor_page.dart';
import 'package:bumbu/features/shopping/presentation/pages/shopping_page.dart';
import 'package:bumbu/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:bumbu/features/profile/presentation/pages/profile_menu_page.dart';
import 'package:bumbu/features/profile/presentation/pages/profile_page.dart';
import 'package:bumbu/features/profile/presentation/pages/user_profile_detail_page.dart';
import 'package:bumbu/features/profile/presentation/pages/social_user_list_page.dart';
import 'package:bumbu/features/profile/presentation/providers/social_provider.dart';
import 'package:bumbu/features/profile/domain/entities/user_profile.dart';
import 'package:bumbu/features/search/presentation/pages/search_page.dart';
import 'package:bumbu/features/splash/presentation/pages/splash_page.dart';
import 'package:bumbu/features/activity/presentation/pages/activity_page.dart';
import 'package:bumbu/features/chat/presentation/pages/chat_page.dart';
import 'package:bumbu/features/kitchen/presentation/pages/kitchen_page.dart';

import 'package:bumbu/app/shell/pages/app_shell.dart';
import 'package:bumbu/app/router/route_names.dart';

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

      // Don't redirect if we're already on a valid social path
      final isSocialPath = location.startsWith('/profile/followers/') || 
                          location.startsWith('/profile/following/');

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
      GoRoute(
        path: RouteNames.recipeEditor,
        builder: (context, state) {
          final recipe = state.extra is Recipe ? state.extra! as Recipe : null;
          return RecipeEditorPage(recipe: recipe);
        },
      ),
      GoRoute(
        path: RouteNames.profileMenu,
        builder: (context, state) => const ProfileMenuPage(),
      ),
      GoRoute(
        path: RouteNames.editProfile,
        builder: (context, state) => const EditProfilePage(),
      ),
      GoRoute(
        path: '/profile/followers/:userId',
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          final title = state.uri.queryParameters['title'] ?? '';
          return SocialUserListPage(
            title: title,
            usersAsync: ref.watch(followersProvider(userId)),
          );
        },
      ),
      GoRoute(
        path: '/profile/following/:userId',
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          final title = state.uri.queryParameters['title'] ?? '';
          return SocialUserListPage(
            title: title,
            usersAsync: ref.watch(followingProvider(userId)),
          );
        },
      ),
      GoRoute(
        path: RouteNames.search,
        builder: (context, state) => const SearchPage(),
        routes: [
          GoRoute(
            path: 'user-profile',
            builder: (context, state) {
              final profile = state.extra as UserProfile;
              return UserProfileDetailPage(profile: profile);
            },
          ),
        ],
      ),

      // ───────── SHELL ─────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
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
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.activity,
                builder: (context, state) => const ActivityPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.chat,
                builder: (context, state) => const ChatPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
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
