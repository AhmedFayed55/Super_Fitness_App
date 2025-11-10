class UserDataResponseEntity {
  UserDataResponseEntity({
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
      required this.createdAt,});

  String id;
  String firstName;
  String lastName;
  String email;
  String gender;
  num age;
  num weight;
  num height;
  String activityLevel;
  String goal;
  String photo;
  String createdAt;
}