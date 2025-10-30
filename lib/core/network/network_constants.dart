abstract class NetworkConstants {
  static const String baseUrl = "https://fitness.elevateegy.com/api/v1/";
  static const String authorization = 'Authorization';
  static const String bearer = "Bearer";
  static const String primeMoverMuscleId = 'primeMoverMuscleId';
  static const String difficultyLevelId = 'difficultyLevelId';
}

abstract class EndPoints {
  static const String login = "auth/signin";
  static const String register = "auth/signup";
  static const String exercises = "exercises/by-muscle-difficulty";
  static const String difficultyLevels =
      "levels/difficulty-levels/by-prime-mover";
}
