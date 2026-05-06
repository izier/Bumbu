import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Bumbu'**
  String get appName;

  /// No description provided for @motto.
  ///
  /// In en, this message translates to:
  /// **'Your kitchen. Your flow.'**
  String get motto;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @kitchen.
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get kitchen;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @discovery.
  ///
  /// In en, this message translates to:
  /// **'Discovery'**
  String get discovery;

  /// No description provided for @social.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get social;

  /// No description provided for @recipes.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get recipes;

  /// No description provided for @pantry.
  ///
  /// In en, this message translates to:
  /// **'Pantry'**
  String get pantry;

  /// No description provided for @shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// No description provided for @cookingMode.
  ///
  /// In en, this message translates to:
  /// **'Cooking Mode'**
  String get cookingMode;

  /// No description provided for @personalization.
  ///
  /// In en, this message translates to:
  /// **'Personalization'**
  String get personalization;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @createANewAccount.
  ///
  /// In en, this message translates to:
  /// **'Join our community of food lovers.'**
  String get createANewAccount;

  /// No description provided for @logInToYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Let\'s get cooking.'**
  String get logInToYourAccount;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get orContinueWith;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already part of the family? Log in'**
  String get alreadyHaveAnAccount;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'New here? Create an account'**
  String get dontHaveAnAccount;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'That doesn\'t look like a valid email address.'**
  String get errorInvalidEmail;

  /// No description provided for @errorWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'The password you entered is incorrect.'**
  String get errorWrongPassword;

  /// No description provided for @errorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find an account with that email or username.'**
  String get errorUserNotFound;

  /// No description provided for @errorEmailAlreadyUsed.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists.'**
  String get errorEmailAlreadyUsed;

  /// No description provided for @errorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Your password should be at least 6 characters long.'**
  String get errorWeakPassword;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Connection error. Please check your internet.'**
  String get errorNetwork;

  /// No description provided for @errorCancelled.
  ///
  /// In en, this message translates to:
  /// **'Sign-in was cancelled.'**
  String get errorCancelled;

  /// No description provided for @errorPopupClosed.
  ///
  /// In en, this message translates to:
  /// **'The sign-in window was closed.'**
  String get errorPopupClosed;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong on our end. Please try again.'**
  String get errorUnknown;

  /// No description provided for @errorEmailEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email.'**
  String get errorEmailEmpty;

  /// No description provided for @errorPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password.'**
  String get errorPasswordEmpty;

  /// No description provided for @errorInvalidCredential.
  ///
  /// In en, this message translates to:
  /// **'The email or password you entered is incorrect.'**
  String get errorInvalidCredential;

  /// No description provided for @recipeTitle.
  ///
  /// In en, this message translates to:
  /// **'Recipe Title'**
  String get recipeTitle;

  /// No description provided for @recipe.
  ///
  /// In en, this message translates to:
  /// **'Recipe'**
  String get recipe;

  /// No description provided for @createRecipe.
  ///
  /// In en, this message translates to:
  /// **'Create Recipe'**
  String get createRecipe;

  /// No description provided for @editRecipe.
  ///
  /// In en, this message translates to:
  /// **'Edit recipe'**
  String get editRecipe;

  /// No description provided for @openRecipeDetail.
  ///
  /// In en, this message translates to:
  /// **'Open recipe detail'**
  String get openRecipeDetail;

  /// No description provided for @recipeId.
  ///
  /// In en, this message translates to:
  /// **'Recipe ID'**
  String get recipeId;

  /// No description provided for @recipeBasics.
  ///
  /// In en, this message translates to:
  /// **'Recipe basics'**
  String get recipeBasics;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @servings.
  ///
  /// In en, this message translates to:
  /// **'Servings'**
  String get servings;

  /// No description provided for @ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredients;

  /// No description provided for @ingredientName.
  ///
  /// In en, this message translates to:
  /// **'Ingredient name'**
  String get ingredientName;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// No description provided for @unitGram.
  ///
  /// In en, this message translates to:
  /// **'g'**
  String get unitGram;

  /// No description provided for @unitKilogram.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get unitKilogram;

  /// No description provided for @unitMilliliter.
  ///
  /// In en, this message translates to:
  /// **'ml'**
  String get unitMilliliter;

  /// No description provided for @unitLiter.
  ///
  /// In en, this message translates to:
  /// **'l'**
  String get unitLiter;

  /// No description provided for @unitPiece.
  ///
  /// In en, this message translates to:
  /// **'pcs'**
  String get unitPiece;

  /// No description provided for @unitTablespoon.
  ///
  /// In en, this message translates to:
  /// **'tbsp'**
  String get unitTablespoon;

  /// No description provided for @unitTeaspoon.
  ///
  /// In en, this message translates to:
  /// **'tsp'**
  String get unitTeaspoon;

  /// No description provided for @unitCup.
  ///
  /// In en, this message translates to:
  /// **'cup'**
  String get unitCup;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// No description provided for @instruction.
  ///
  /// In en, this message translates to:
  /// **'Instruction'**
  String get instruction;

  /// No description provided for @durationSeconds.
  ///
  /// In en, this message translates to:
  /// **'Duration (seconds)'**
  String get durationSeconds;

  /// No description provided for @secondsShort.
  ///
  /// In en, this message translates to:
  /// **'sec'**
  String get secondsShort;

  /// No description provided for @addIngredient.
  ///
  /// In en, this message translates to:
  /// **'Add ingredient'**
  String get addIngredient;

  /// No description provided for @addStep.
  ///
  /// In en, this message translates to:
  /// **'Add step'**
  String get addStep;

  /// No description provided for @saveRecipe.
  ///
  /// In en, this message translates to:
  /// **'Save recipe'**
  String get saveRecipe;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @removeIngredient.
  ///
  /// In en, this message translates to:
  /// **'Remove ingredient'**
  String get removeIngredient;

  /// No description provided for @removeStep.
  ///
  /// In en, this message translates to:
  /// **'Remove step'**
  String get removeStep;

  /// No description provided for @noIngredients.
  ///
  /// In en, this message translates to:
  /// **'No ingredients yet'**
  String get noIngredients;

  /// No description provided for @noSteps.
  ///
  /// In en, this message translates to:
  /// **'No steps yet'**
  String get noSteps;

  /// No description provided for @notAuthenticated.
  ///
  /// In en, this message translates to:
  /// **'Not authenticated'**
  String get notAuthenticated;

  /// No description provided for @recipeSaved.
  ///
  /// In en, this message translates to:
  /// **'Recipe saved'**
  String get recipeSaved;

  /// No description provided for @recipeUpdated.
  ///
  /// In en, this message translates to:
  /// **'Recipe updated'**
  String get recipeUpdated;

  /// No description provided for @editIngredient.
  ///
  /// In en, this message translates to:
  /// **'Edit ingredient'**
  String get editIngredient;

  /// No description provided for @editStep.
  ///
  /// In en, this message translates to:
  /// **'Edit step'**
  String get editStep;

  /// No description provided for @saveIngredient.
  ///
  /// In en, this message translates to:
  /// **'Save ingredient'**
  String get saveIngredient;

  /// No description provided for @saveStep.
  ///
  /// In en, this message translates to:
  /// **'Save step'**
  String get saveStep;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @indonesian.
  ///
  /// In en, this message translates to:
  /// **'Indonesian'**
  String get indonesian;

  /// No description provided for @searchLoadedRecipes.
  ///
  /// In en, this message translates to:
  /// **'Explore a world of flavors by searching recipes.'**
  String get searchLoadedRecipes;

  /// No description provided for @noRecipesFound.
  ///
  /// In en, this message translates to:
  /// **'No recipes found matching your search.'**
  String get noRecipesFound;

  /// No description provided for @tryAnotherSearchOrAddRecipe.
  ///
  /// In en, this message translates to:
  /// **'Try a different keyword or create your own recipe to share!'**
  String get tryAnotherSearchOrAddRecipe;

  /// No description provided for @couldNotLoadRecipes.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t fetch recipes right now.'**
  String get couldNotLoadRecipes;

  /// No description provided for @couldNotLoadYourRecipes.
  ///
  /// In en, this message translates to:
  /// **'Could not load your recipes'**
  String get couldNotLoadYourRecipes;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @loadTenMore.
  ///
  /// In en, this message translates to:
  /// **'Load 10 more'**
  String get loadTenMore;

  /// No description provided for @pullUpToLoadTenMore.
  ///
  /// In en, this message translates to:
  /// **'Pull up to load 10 more'**
  String get pullUpToLoadTenMore;

  /// No description provided for @allCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up on the latest!'**
  String get allCaughtUp;

  /// No description provided for @yourRecipesWillAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Your culinary masterpieces will show up here.'**
  String get yourRecipesWillAppearHere;

  /// No description provided for @profileNoRecipesYetTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to share your first recipe?'**
  String get profileNoRecipesYetTitle;

  /// No description provided for @profileNoRecipesYetBody.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t shared any recipes yet. Start your journey by adding your first creation!'**
  String get profileNoRecipesYetBody;

  /// No description provided for @loadingRecipes.
  ///
  /// In en, this message translates to:
  /// **'Loading recipes'**
  String get loadingRecipes;

  /// No description provided for @servingCountOne.
  ///
  /// In en, this message translates to:
  /// **'1 serving'**
  String get servingCountOne;

  /// No description provided for @servingCountOther.
  ///
  /// In en, this message translates to:
  /// **'{count} servings'**
  String servingCountOther(Object count);

  /// No description provided for @itemCountOne.
  ///
  /// In en, this message translates to:
  /// **'1 item'**
  String get itemCountOne;

  /// No description provided for @itemCountOther.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String itemCountOther(Object count);

  /// No description provided for @ingredientCountOne.
  ///
  /// In en, this message translates to:
  /// **'1 ingredient'**
  String get ingredientCountOne;

  /// No description provided for @ingredientCountOther.
  ///
  /// In en, this message translates to:
  /// **'{count} ingredients'**
  String ingredientCountOther(Object count);

  /// No description provided for @secondCountOne.
  ///
  /// In en, this message translates to:
  /// **'1 sec'**
  String get secondCountOne;

  /// No description provided for @secondCountOther.
  ///
  /// In en, this message translates to:
  /// **'{count} sec'**
  String secondCountOther(Object count);

  /// No description provided for @minuteCountOne.
  ///
  /// In en, this message translates to:
  /// **'1 min'**
  String get minuteCountOne;

  /// No description provided for @minuteCountOther.
  ///
  /// In en, this message translates to:
  /// **'{count} min'**
  String minuteCountOther(Object count);

  /// No description provided for @hourCountOne.
  ///
  /// In en, this message translates to:
  /// **'1 hr'**
  String get hourCountOne;

  /// No description provided for @hourCountOther.
  ///
  /// In en, this message translates to:
  /// **'{count} hr'**
  String hourCountOther(Object count);

  /// No description provided for @dayCountOne.
  ///
  /// In en, this message translates to:
  /// **'1 day'**
  String get dayCountOne;

  /// No description provided for @dayCountOther.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String dayCountOther(Object count);

  /// No description provided for @errorEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Give your recipe a catchy title!'**
  String get errorEmptyTitle;

  /// No description provided for @errorEmptyIngredientName.
  ///
  /// In en, this message translates to:
  /// **'What\'s the name of this ingredient?'**
  String get errorEmptyIngredientName;

  /// No description provided for @errorInvalidQuantity.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount.'**
  String get errorInvalidQuantity;

  /// No description provided for @errorEmptyInstruction.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget the instructions for this step!'**
  String get errorEmptyInstruction;

  /// No description provided for @errorInvalidDuration.
  ///
  /// In en, this message translates to:
  /// **'How long does this step take?'**
  String get errorInvalidDuration;

  /// No description provided for @errorEmptyIngredients.
  ///
  /// In en, this message translates to:
  /// **'Your recipe needs at least one ingredient.'**
  String get errorEmptyIngredients;

  /// No description provided for @errorEmptySteps.
  ///
  /// In en, this message translates to:
  /// **'Your recipe needs at least one step.'**
  String get errorEmptySteps;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @errorSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorSomethingWentWrong;

  /// No description provided for @emailOrUsernameLogin.
  ///
  /// In en, this message translates to:
  /// **'Email or username'**
  String get emailOrUsernameLogin;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get displayName;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @errorPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get errorPasswordMismatch;

  /// No description provided for @errorUsernameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Username must be at least 3 characters.'**
  String get errorUsernameMinLength;

  /// No description provided for @errorUsernameAlreadyUsed.
  ///
  /// In en, this message translates to:
  /// **'That username is already taken.'**
  String get errorUsernameAlreadyUsed;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// No description provided for @searchPeopleAndRecipes.
  ///
  /// In en, this message translates to:
  /// **'Discover foodies and trending recipes.'**
  String get searchPeopleAndRecipes;

  /// No description provided for @tabAccounts.
  ///
  /// In en, this message translates to:
  /// **'Creators'**
  String get tabAccounts;

  /// No description provided for @tabRecipes.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get tabRecipes;

  /// No description provided for @follow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get follow;

  /// No description provided for @following.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get following;

  /// No description provided for @statRecipes.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get statRecipes;

  /// No description provided for @statFollowers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get statFollowers;

  /// No description provided for @statFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get statFollowing;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profileUpdated;

  /// No description provided for @featureComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get featureComingSoon;

  /// No description provided for @loadingApp.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loadingApp;

  /// No description provided for @brandGoogle.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get brandGoogle;

  /// No description provided for @brandApple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get brandApple;

  /// No description provided for @noSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No creators found.'**
  String get noSearchResults;

  /// No description provided for @publicProfileNoRecipes.
  ///
  /// In en, this message translates to:
  /// **'This creator hasn\'t shared any recipes yet.'**
  String get publicProfileNoRecipes;

  /// No description provided for @publicProfileNoRecipesDetail.
  ///
  /// In en, this message translates to:
  /// **'Follow them to stay updated when they post their first masterpiece!'**
  String get publicProfileNoRecipesDetail;

  /// No description provided for @searchCreatorsEngage.
  ///
  /// In en, this message translates to:
  /// **'Discover new creators and fellow foodies.'**
  String get searchCreatorsEngage;

  /// No description provided for @searchRecipesEngage.
  ///
  /// In en, this message translates to:
  /// **'Find your next favorite meal or explore trending flavors.'**
  String get searchRecipesEngage;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'id': return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
