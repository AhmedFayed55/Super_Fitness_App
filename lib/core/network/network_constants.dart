abstract class NetworkConstants {
  static const String baseUrl = "https://fitness.elevateegy.com/api/v1/";
  static const String baseUrlMeals = "www.themealdb.com/api/json/v1/1/";
  static const String authorization = 'Authorization';
  static const String bearer = "Bearer";
  static const String mealsApiClient = 'dioMeals';
}

abstract class EndPoints {
  static const String login = "auth/signin";
  static const String register = "auth/signup";
  static const String forgotPassword = "auth/forgotPassword";
  static const String verifyResetCode = "auth/verifyResetCode";
  static const String resetPassword = "auth/resetPassword";
  static const String recommendationToDay = "muscles/random";
  static const String upcomingWorkoutsTab = "muscles";
  static const String upcomingWorkoutsTabItems = "musclesGroup/{muscleGroupId}";
  static const String recommendationForYou = "categories.php";
  static const String logout = 'auth/logout';
}
