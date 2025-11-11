import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_state.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_view_model.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/video_player_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'video_player_widget_test.mocks.dart';

@GenerateMocks([DetailsFoodViewModel])
void main() {
  late MockDetailsFoodViewModel mockCubit;

  setUp(() {
    mockCubit = MockDetailsFoodViewModel();

    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCubit.state).thenReturn(DetailsFoodState(youtubeController: null));
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<DetailsFoodViewModel>.value(
        value: mockCubit,
        child: Scaffold(body: child),
      ),
    );
  }

  group('VideoPlayerWidget using Mockito', () {
    testWidgets('shows loading indicator when controller is null', (
      tester,
    ) async {
      when(
        mockCubit.state,
      ).thenReturn(DetailsFoodState(youtubeController: null));

      await tester.pumpWidget(makeTestableWidget(const VideoPlayerWidget()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(YoutubePlayer), findsNothing);
    });
  });
}
