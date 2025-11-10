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
