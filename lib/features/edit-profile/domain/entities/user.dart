import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final int age;
  final int weight;
  final int height;
  final String activityLevel;
  final String goal;
  final String photo;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
    required this.activityLevel,
    required this.goal,
    required this.photo,
    required this.createdAt,
  });

  UserEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    int? age,
    int? weight,
    int? height,
    String? activityLevel,
    String? goal,
    String? photo,
    DateTime? createdAt,
  }) => UserEntity(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    gender: gender ?? this.gender,
    age: age ?? this.age,
    weight: weight ?? this.weight,
    height: height ?? this.height,
    activityLevel: activityLevel ?? this.activityLevel,
    goal: goal ?? this.goal,
    photo: photo ?? this.photo,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    gender,
    age,
    weight,
    height,
    activityLevel,
    goal,
    photo,
    createdAt,
  ];
}
