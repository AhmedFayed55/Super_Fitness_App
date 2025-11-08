enum ActivityLevel {
  rookie,
  beginner,
  intermediate,
  advance,
  trueBeast;

  String get displayName {
    switch (this) {
      case ActivityLevel.rookie:
        return "Rookie";
      case ActivityLevel.beginner:
        return "Beginner";
      case ActivityLevel.intermediate:
        return "Intermediate";
      case ActivityLevel.advance:
        return "Advance";
      case ActivityLevel.trueBeast:
        return "True Beast";
    }
  }

  static ActivityLevel fromString(String value) {
    switch (value.toLowerCase()) {
      case "rookie":
        return ActivityLevel.rookie;
      case "beginner":
        return ActivityLevel.beginner;
      case "intermediate":
        return ActivityLevel.intermediate;
      case "advance":
        return ActivityLevel.advance;
      case "true_beast":
      case "true beast":
        return ActivityLevel.trueBeast;
      default:
        throw Exception("Invalid activity level: $value");
    }
  }

  static String toLevelName(String value) {
    switch (value.toLowerCase()) {
      case "rookie":
        return "level1";
      case "beginner":
        return "level2";
      case "intermediate":
        return "level3";
      case "advance":
        return "level4";
      case "true beast":
        return "level5";
      default:
        throw Exception("Invalid activity level: $value");
    }
  }
}
