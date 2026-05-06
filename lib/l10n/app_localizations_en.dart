// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Bumbu';

  @override
  String get motto => 'Your kitchen. Your flow.';

  @override
  String get home => 'Home';

  @override
  String get kitchen => 'Kitchen';

  @override
  String get activity => 'Activity';

  @override
  String get chat => 'Chat';

  @override
  String get profile => 'Profile';

  @override
  String get discovery => 'Discovery';

  @override
  String get social => 'Social';

  @override
  String get recipes => 'Recipes';

  @override
  String get pantry => 'Pantry';

  @override
  String get shopping => 'Shopping';

  @override
  String get cookingMode => 'Cooking Mode';

  @override
  String get personalization => 'Personalization';

  @override
  String get getStarted => 'Get Started';

  @override
  String get createANewAccount => 'Join our community of food lovers.';

  @override
  String get logInToYourAccount => 'Welcome back! Let\'s get cooking.';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get createAccount => 'Create Account';

  @override
  String get orContinueWith => 'or continue with';

  @override
  String get alreadyHaveAnAccount => 'Already part of the family? Log in';

  @override
  String get dontHaveAnAccount => 'New here? Create an account';

  @override
  String get errorInvalidEmail => 'That doesn\'t look like a valid email address.';

  @override
  String get errorWrongPassword => 'The password you entered is incorrect.';

  @override
  String get errorUserNotFound => 'We couldn\'t find an account with that email or username.';

  @override
  String get errorEmailAlreadyUsed => 'An account with this email already exists.';

  @override
  String get errorWeakPassword => 'Your password should be at least 6 characters long.';

  @override
  String get errorNetwork => 'Connection error. Please check your internet.';

  @override
  String get errorCancelled => 'Sign-in was cancelled.';

  @override
  String get errorPopupClosed => 'The sign-in window was closed.';

  @override
  String get errorUnknown => 'Something went wrong on our end. Please try again.';

  @override
  String get errorEmailEmpty => 'Please enter your email.';

  @override
  String get errorPasswordEmpty => 'Please enter your password.';

  @override
  String get errorInvalidCredential => 'The email or password you entered is incorrect.';

  @override
  String get recipeTitle => 'Recipe Title';

  @override
  String get recipe => 'Recipe';

  @override
  String get createRecipe => 'Create Recipe';

  @override
  String get editRecipe => 'Edit recipe';

  @override
  String get openRecipeDetail => 'Open recipe detail';

  @override
  String get recipeId => 'Recipe ID';

  @override
  String get recipeBasics => 'Recipe basics';

  @override
  String get description => 'Description';

  @override
  String get servings => 'Servings';

  @override
  String get ingredients => 'Ingredients';

  @override
  String get ingredientName => 'Ingredient name';

  @override
  String get quantity => 'Quantity';

  @override
  String get unit => 'Unit';

  @override
  String get unitGram => 'g';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitMilliliter => 'ml';

  @override
  String get unitLiter => 'l';

  @override
  String get unitPiece => 'pcs';

  @override
  String get unitTablespoon => 'tbsp';

  @override
  String get unitTeaspoon => 'tsp';

  @override
  String get unitCup => 'cup';

  @override
  String get steps => 'Steps';

  @override
  String get instruction => 'Instruction';

  @override
  String get durationSeconds => 'Duration (seconds)';

  @override
  String get secondsShort => 'sec';

  @override
  String get addIngredient => 'Add ingredient';

  @override
  String get addStep => 'Add step';

  @override
  String get saveRecipe => 'Save recipe';

  @override
  String get cancel => 'Cancel';

  @override
  String get remove => 'Remove';

  @override
  String get removeIngredient => 'Remove ingredient';

  @override
  String get removeStep => 'Remove step';

  @override
  String get noIngredients => 'No ingredients yet';

  @override
  String get noSteps => 'No steps yet';

  @override
  String get notAuthenticated => 'Not authenticated';

  @override
  String get recipeSaved => 'Recipe saved';

  @override
  String get recipeUpdated => 'Recipe updated';

  @override
  String get editIngredient => 'Edit ingredient';

  @override
  String get editStep => 'Edit step';

  @override
  String get saveIngredient => 'Save ingredient';

  @override
  String get saveStep => 'Save step';

  @override
  String get menu => 'Menu';

  @override
  String get logout => 'Logout';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get english => 'English';

  @override
  String get indonesian => 'Indonesian';

  @override
  String get searchLoadedRecipes => 'Explore a world of flavors by searching recipes.';

  @override
  String get noRecipesFound => 'No recipes found matching your search.';

  @override
  String get tryAnotherSearchOrAddRecipe => 'Try a different keyword or create your own recipe to share!';

  @override
  String get couldNotLoadRecipes => 'We couldn\'t fetch recipes right now.';

  @override
  String get couldNotLoadYourRecipes => 'Could not load your recipes';

  @override
  String get tryAgain => 'Try again';

  @override
  String get loadTenMore => 'Load 10 more';

  @override
  String get pullUpToLoadTenMore => 'Pull up to load 10 more';

  @override
  String get allCaughtUp => 'You\'re all caught up on the latest!';

  @override
  String get yourRecipesWillAppearHere => 'Your culinary masterpieces will show up here.';

  @override
  String get profileNoRecipesYetTitle => 'Ready to share your first recipe?';

  @override
  String get profileNoRecipesYetBody => 'You haven\'t shared any recipes yet. Start your journey by adding your first creation!';

  @override
  String get loadingRecipes => 'Loading recipes';

  @override
  String get servingCountOne => '1 serving';

  @override
  String servingCountOther(Object count) {
    return '$count servings';
  }

  @override
  String get itemCountOne => '1 item';

  @override
  String itemCountOther(Object count) {
    return '$count items';
  }

  @override
  String get ingredientCountOne => '1 ingredient';

  @override
  String ingredientCountOther(Object count) {
    return '$count ingredients';
  }

  @override
  String get secondCountOne => '1 sec';

  @override
  String secondCountOther(Object count) {
    return '$count sec';
  }

  @override
  String get minuteCountOne => '1 min';

  @override
  String minuteCountOther(Object count) {
    return '$count min';
  }

  @override
  String get hourCountOne => '1 hr';

  @override
  String hourCountOther(Object count) {
    return '$count hr';
  }

  @override
  String get dayCountOne => '1 day';

  @override
  String dayCountOther(Object count) {
    return '$count days';
  }

  @override
  String get errorEmptyTitle => 'Give your recipe a catchy title!';

  @override
  String get errorEmptyIngredientName => 'What\'s the name of this ingredient?';

  @override
  String get errorInvalidQuantity => 'Please enter a valid amount.';

  @override
  String get errorEmptyInstruction => 'Don\'t forget the instructions for this step!';

  @override
  String get errorInvalidDuration => 'How long does this step take?';

  @override
  String get errorEmptyIngredients => 'Your recipe needs at least one ingredient.';

  @override
  String get errorEmptySteps => 'Your recipe needs at least one step.';

  @override
  String get loading => 'Loading...';

  @override
  String get errorSomethingWentWrong => 'Something went wrong';

  @override
  String get emailOrUsernameLogin => 'Email or username';

  @override
  String get username => 'Username';

  @override
  String get displayName => 'Display name';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get errorPasswordMismatch => 'Passwords do not match.';

  @override
  String get errorUsernameMinLength => 'Username must be at least 3 characters.';

  @override
  String get errorUsernameAlreadyUsed => 'That username is already taken.';

  @override
  String get searchTitle => 'Search';

  @override
  String get searchPeopleAndRecipes => 'Discover foodies and trending recipes.';

  @override
  String get tabAccounts => 'Creators';

  @override
  String get tabRecipes => 'Recipes';

  @override
  String get follow => 'Follow';

  @override
  String get following => 'Following';

  @override
  String get statRecipes => 'Recipes';

  @override
  String get statFollowers => 'Followers';

  @override
  String get statFollowing => 'Following';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get save => 'Save';

  @override
  String get profileUpdated => 'Profile updated';

  @override
  String get featureComingSoon => 'Coming soon';

  @override
  String get loadingApp => 'Loading';

  @override
  String get brandGoogle => 'Google';

  @override
  String get brandApple => 'Apple';

  @override
  String get noSearchResults => 'No creators found.';

  @override
  String get publicProfileNoRecipes => 'This creator hasn\'t shared any recipes yet.';

  @override
  String get publicProfileNoRecipesDetail => 'Follow them to stay updated when they post their first masterpiece!';

  @override
  String get searchCreatorsEngage => 'Discover new creators and fellow foodies.';

  @override
  String get searchRecipesEngage => 'Find your next favorite meal or explore trending flavors.';
}
