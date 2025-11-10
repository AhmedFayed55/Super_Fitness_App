enum ContentType { help, privacy, security }
enum ExerciseScreenMode { byMuscleId, byPreloadedData }

enum Level {
  beginner,
  intermediate,
  novice,
  advanced,
  expert,
  grandMaster,
  master,
  legendary;

  String getAr(Level level) {
    switch (level) {
      case Level.beginner:
        return 'مبتدئ';
      case Level.intermediate:
        return 'متوسط';
      case Level.novice:
        return 'مبتدئ';
      case Level.advanced:
        return 'متقدم';
      case Level.expert:
        return 'خبير';
      case Level.grandMaster:
        return 'سيد عظيم';
      case Level.master:
        return 'ماستر';
      case Level.legendary:
        return 'أسطوري';
    }
  }

  String getEn(Level level) {
    switch (level) {
      case Level.beginner:
        return 'Beginner';
      case Level.intermediate:
        return 'Intermediate';
      case Level.novice:
        return 'Novice';
      case Level.advanced:
        return 'Advanced';
      case Level.expert:
        return 'Expert';
      case Level.grandMaster:
        return 'Grand Master';
      case Level.master:
        return 'Master';
      case Level.legendary:
        return 'Legendary';
    }
  }

  Level getLevelEn(String level) {
    switch (level) {
      case 'Beginner':
        return Level.beginner;
      case 'Intermediate':
        return Level.intermediate;
      case 'Novice':
        return Level.novice;
      case 'Advanced':
        return Level.advanced;
      case 'Expert':
        return Level.expert;
      case 'Grand Master':
        return Level.grandMaster;
      case 'Master':
        return Level.master;
      case 'Legendary':
        return Level.legendary;
      default:
        return Level.beginner;
    }
  }
}

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
