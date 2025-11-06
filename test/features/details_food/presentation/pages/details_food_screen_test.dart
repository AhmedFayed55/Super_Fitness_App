import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_state.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_view_model.dart';
import 'package:super_fitness_app/features/details_food/presentation/pages/details_food_screen.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/video_player_loading_shimmer.dart';
import 'details_food_screen_test.mocks.dart';

@GenerateMocks([DetailsFoodViewModel])
void main() {
  late DetailsFoodViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockDetailsFoodViewModel();

    // Stub للـ state و stream
    when(mockViewModel.state).thenReturn(DetailsFoodState());
    when(
      mockViewModel.stream,
    ).thenAnswer((_) => Stream.value(DetailsFoodState()));
    // when(mockViewModel.doIntent(any)).thenReturn(null);

    // تسجيل الـ mock في GetIt
    if (getIt.isRegistered<DetailsFoodViewModel>()) {
      getIt.unregister<DetailsFoodViewModel>();
    }
    getIt.registerFactory<DetailsFoodViewModel>(() => mockViewModel);
  });

  Widget createTestWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<DetailsFoodViewModel>.value(
        value: mockViewModel,
        child: const DetailsFoodScreen(), // بدون const
      ),
    );
  }

  group('DetailsFoodScreen Widget Tests', () {
    testWidgets('shows SafeArea and Scaffold', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('shows loading shimmer when isLoading is true', (tester) async {
      when(mockViewModel.state).thenReturn(DetailsFoodState(isLoading: true));
      when(
        mockViewModel.stream,
      ).thenAnswer((_) => Stream.value(DetailsFoodState(isLoading: true)));

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byType(VideoPlayerLoadingShimmer), findsOneWidget);
    });

    testWidgets('shows error message when errorMessage is not empty', (
      tester,
    ) async {
      const errorMessage = 'Failed to load data';
      when(
        mockViewModel.state,
      ).thenReturn(DetailsFoodState(errorMessage: errorMessage));
      when(mockViewModel.stream).thenAnswer(
        (_) => Stream.value(DetailsFoodState(errorMessage: errorMessage)),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.text(errorMessage), findsOneWidget);
    });
  });
}
