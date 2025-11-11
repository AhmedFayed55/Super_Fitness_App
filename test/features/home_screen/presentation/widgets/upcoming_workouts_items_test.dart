import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/upcoming_workouts_items.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_view_model.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_state.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';

import 'recommendation_for_you_test.mocks.dart';

@GenerateMocks([HomeCubit])
void main() {
  late MockHomeCubit mockHomeCubit;

  setUp(() {
    mockHomeCubit = MockHomeCubit();
  });

  Widget createWidgetUnderTest(HomeState state) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: BlocProvider<HomeCubit>.value(
        value: mockHomeCubit,
        child: const Scaffold(body: UpcomingWorkoutsItems()),
      ),
    );
  }

  testWidgets('UpcomingWorkoutsItems shows loading indicator when loading', (
    tester,
  ) async {
    const homeState = HomeState(
      upcomingTabItems: ScreenStatus.isLoading,
      upcomingTabItemsData: null,
    );

    when(mockHomeCubit.state).thenReturn(homeState);
    when(
      mockHomeCubit.stream,
    ).thenAnswer((_) => Stream<HomeState>.value(homeState));

    await tester.pumpWidget(createWidgetUnderTest(homeState));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('UpcomingWorkoutsItems shows placeholder text when no data', (
    tester,
  ) async {
    const homeState = HomeState(
      upcomingTabItems: ScreenStatus.isSuccess,
      upcomingTabItemsData: null,
    );

    when(mockHomeCubit.state).thenReturn(homeState);
    when(
      mockHomeCubit.stream,
    ).thenAnswer((_) => Stream<HomeState>.value(homeState));

    await tester.pumpWidget(createWidgetUnderTest(homeState));
    await tester.pumpAndSettle();
  });
}
