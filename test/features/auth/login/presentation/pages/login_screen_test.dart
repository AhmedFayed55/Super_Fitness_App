import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/general_cubits/locale_cubit.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/auth/login/presentation/manager/login_screen_state.dart';
import 'package:super_fitness_app/features/auth/login/presentation/manager/login_screen_view_model.dart';
import 'package:super_fitness_app/features/auth/login/presentation/pages/login_screen.dart';
import 'package:super_fitness_app/features/auth/login/presentation/widgets/blur_widget.dart';

import 'login_screen_test.mocks.dart';

@GenerateMocks([LoginScreenViewModel, LocaleCubit])
void main() {
  late LoginScreenViewModel viewModel;
  late LocaleCubit localeCubit;
  late AppLocalizations localization;

  Widget _buildLoginScreen() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => localeCubit),
          BlocProvider(create: (_) => viewModel),
        ],
        child: const LoginScreen(),
      ),
    );
  }

  setUpAll(() async {
    localization = await AppLocalizations.delegate.load(const Locale('en'));
    viewModel = MockLoginScreenViewModel();
    localeCubit = MockLocaleCubit();

    when(localeCubit.state).thenReturn(const Locale('en'));
    when(
      localeCubit.stream,
    ).thenAnswer((_) => Stream.value(const Locale('en')));

    when(viewModel.state).thenReturn(const LoginScreenState());
    when(
      viewModel.stream,
    ).thenAnswer((_) => Stream.value(const LoginScreenState()));

    when(viewModel.formKey).thenReturn(GlobalKey<FormState>());
    when(viewModel.emailController).thenReturn(TextEditingController());
    when(viewModel.passController).thenReturn(TextEditingController());
    if (!getIt.isRegistered<LoginScreenViewModel>()) {
      getIt.registerSingleton<LoginScreenViewModel>(viewModel);
    } else {
      getIt.unregister<LoginScreenViewModel>();
      getIt.registerSingleton<LoginScreenViewModel>(viewModel);
    }
  });

  tearDown(() {
    if (getIt.isRegistered<LoginScreenViewModel>()) {
      getIt.unregister<LoginScreenViewModel>();
    }
  });

  testWidgets('Verify LoginScreen structure correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildLoginScreen());
    expect(find.text(localization.hey_there), findsOneWidget);
    expect(find.text(localization.welcome_back), findsOneWidget);
    expect(find.text(localization.login), findsNWidgets(2));
    expect(find.text(localization.email), findsOneWidget);
    expect(find.text(localization.password), findsOneWidget);
    expect(find.text(localization.forget_password_ques), findsOneWidget);
    expect(find.text(localization.or), findsOneWidget);
    expect(
      find.textContaining(localization.dont_have_account_yet),
      findsOneWidget,
    );
    expect(find.textContaining(localization.register), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(9)); // Text.rich 1 only
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(Image), findsNWidgets(3));
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(LayoutBuilder), findsOneWidget);
    expect(find.byType(Stack), findsNWidgets(3));
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(5));
    expect(find.byType(Icon), findsNWidgets(6));
    expect(find.byType(BlurWidget), findsOneWidget);
    expect(find.byType(Divider), findsNWidgets(2));
    expect(find.byType(CustomElevatedButton), findsOneWidget);
    expect(find.byType(Align), findsOneWidget);
    expect(find.byType(IntrinsicHeight), findsNWidgets(2));
    expect(find.byType(Form), findsOneWidget);
    final backgroundFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName.contains(
            AppAssets.loginBackground,
          ),
    );
    expect(backgroundFinder, findsOneWidget);
    final logoImageFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName.contains(AppAssets.appLogo),
    );
    expect(logoImageFinder, findsOneWidget);
    expect(viewModel.emailController, isNotNull);
    expect(viewModel.passController, isNotNull);
  });
}
