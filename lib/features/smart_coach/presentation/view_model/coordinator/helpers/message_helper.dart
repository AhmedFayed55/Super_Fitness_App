import 'package:super_fitness_app/core/utils/constants.dart';

class MessageHelper {
  static String buildContextualMessage({
    required String text,
    required dynamic user,
  }) {
    return AppConstants.userProfileTemplate
        .replaceAll('{name}', user.fullName ?? 'Unknown')
        .replaceAll('{age}', '${user.age ?? 'N/A'}')
        .replaceAll('{weight}', '${user.weight ?? 'N/A'}')
        .replaceAll('{height}', '${user.height ?? 'N/A'}')
        .replaceAll('{activityLevel}', user.activityLevel ?? 'N/A')
        .replaceAll('{goal}', user.goal ?? 'N/A')
        .replaceAll('{message}', text);
  }

  static bool isArabic(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text);
  }
}
