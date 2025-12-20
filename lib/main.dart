import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:super_fitness_app/config/routing/initial_route.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/general_cubits/locale_cubit.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_view_model.dart';
import 'package:super_fitness_app/firebase_options.dart';
import 'config/routing/route_generator.dart';
import 'config/theme/app_theme.dart';
import 'core/l10n/translations/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "secret.env");

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (e.toString().contains('duplicate-app')) {
    } else {
      rethrow;
    }
  }
  await configureDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(create: (context) => getIt<LocaleCubit>()),
        BlocProvider<SmartChatViewModel>(
          create: (context) => getIt<SmartChatViewModel>(),
        ),
      ],
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
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: getInitialRoute(),
        );
      },
    );
  }
}
