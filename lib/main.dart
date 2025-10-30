import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/general_cubits/locale_cubit.dart';
<<<<<<< HEAD
import 'package:super_fitness_app/core/helpers/shared_pref.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'config/routing/route_generator.dart';
=======
import 'package:super_fitness_app/features/details_food/presentation/pages/details_food_screen.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/video_player_widget.dart';
>>>>>>> fd79c2479349f9204573b89ec3c34e6409b578ec
import 'config/theme/app_theme.dart';
import 'core/l10n/translations/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(
    BlocProvider(
      create: (context) => getIt<LocaleCubit>(),
      child: const SuperFitnessApp(),
    ),
  );
}

class SuperFitnessApp extends StatelessWidget {
  const SuperFitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, state) {
        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(state.languageCode),
          theme: AppTheme.darkTheme,
<<<<<<< HEAD
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: AppRoutes.appSections,

          // initialRoute:
          //     getIt<SharedPrefHelper>().getData(
          //           key: AppConstants.isOnBoardingSeen,
          //         ) !=
          //         null
          //     ? AppRoutes.login
          //     : AppRoutes.onboarding,
=======
           debugShowCheckedModeBanner: false,
          // onGenerateRoute: RouteGenerator.getRoute,
          // initialRoute: AppRoutes.login,
          home: DetailsFoodScreen(),
>>>>>>> fd79c2479349f9204573b89ec3c34e6409b578ec
        );
      },
    );
  }
}
