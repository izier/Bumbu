class RouteNames {
  // Core
  static const splash = '/';
  static const landing = '/landing';
  static const auth = '/auth';

  // Main Shell
  static const home = '/home';
  static const kitchen = '/kitchen';
  static const activity = '/activity';
  static const chat = '/chat';
  static const profile = '/profile';
  static String userProfilePath(String id) =>
      '$profile/${Uri.encodeComponent(id)}';
  static const profileMenu = '/profile/menu';
  static const editProfile = '/profile/edit';

  /// Full-screen search (recipes + people).
  static const search = '/search';

  // Home
  static const recipeDetail = '/recipe';
  static const recipeEditor = '/recipe-editor';
  static String recipeDetailPath(String id) =>
      '$recipeDetail/${Uri.encodeComponent(id)}';

  // Kitchen
  static const pantry = '/kitchen/pantry';
  static const shopping = '/kitchen/shopping';

  // Activity
  static const activityCurrent = '/activity/current';
  static const activityHistory = '/activity/history';

  // Chat
  static const chatRoom = '/chat/room';

  // Cooking
  static const cooking = '/cooking';
}
