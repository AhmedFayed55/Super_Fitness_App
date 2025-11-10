part of 'popular_cubit.dart';

class PopularState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final List<PopularData>? popularData;

  const PopularState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.popularData,
  });

  PopularState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    List<PopularData>? popularData,
  }) {
    return PopularState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      popularData: popularData ?? this.popularData,
    );
  }

  @override
  List<Object> get props => [
    isLoading,
    isSuccess,
    errorMessage ?? '',
    popularData ?? [],
  ];
}

class PopularData extends Equatable {
  final List<ExerciseEntity>? exercises;
  final Level level;

  const PopularData({this.exercises, required this.level});

  PopularData copyWith({List<ExerciseEntity>? exercises, Level? level}) {
    return PopularData(
      exercises: exercises ?? this.exercises,
      level: level ?? this.level,
    );
  }

  @override
  List<Object?> get props => [exercises, level];
}
