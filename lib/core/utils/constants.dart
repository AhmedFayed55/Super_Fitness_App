/// Application-wide constants used across the project.
abstract class AppConstants {
  // 🔹 Shared Preferences Keys
  static const String token = 'token';
  static const String isTokenSaved = 'isTokenSaved';
  static const String isRemember = 'isRemember';

  // 🔹 Localization Keys
  static const String languageCode = 'languageCode';
  static const String arKey = 'ar';
  static const String enKey = 'en';
  static const String countyEnergy = '100 K';
  static const String countyProtein = '15 G';
  static const String countyCarbs = '58 G';
  static const String countyFat = '20 G';
  static const double sigmaX = 34;
  static const double sigmaY = 34;
  static const String exercises = 'exercises';
  static const String difficulties = 'difficulties';
  static const String isOnBoardingSeen = 'onboarding_seen';

  // 🔹 General Constants
  static const String noInternet = 'No Internet Connection';
  static const int animateSeconds = 300;
  static const double blurSigma = 10;

  // 🔹 Firestore Collections
  static const String usersCollection = 'users';
  static const String chatsCollection = 'chats';
  static const String messagesCollection = 'messages';

  // 🔹 Default Values
  static const String defaultChatTitle = 'New Chat';
  static const String defaultError = 'An unexpected error occurred';

  // 🔹 Chat Role Identifiers
  static const String userAuthorId = 'user1';
  static const String botAuthorId = 'bot';
  static const String userSender = 'user';
  static const String botSender = 'bot';
  static const String userMessageSuffix = 'user';
  static const String botMessageSuffix = 'bot';
  static const String errorMessageSuffix = 'error';

  // 🔹 Error & Info Messages
  static const String errorMessageText =
      'Sorry, something went wrong. Please try again.';

  // 🔹 User Profile Context Template
  static const String userProfileTemplate = '''
User Profile Context:
- Name: {name}
- Age: {age} years
- Weight: {weight} kg
- Height: {height} cm
- Activity Level: {activityLevel}
- Goal: {goal}

User Message: {message}
''';
  static const String firstName = "firstName";
  static const String lastName = "lastName";
  static const String email = "email";
  static const String weight = "weight";
  static const String activityLevel = "activityLevel";
  static const String goal = "goal";

  //key navigate map
  static const String mealId = 'id';
  static const String mealList = 'mealList';
}
