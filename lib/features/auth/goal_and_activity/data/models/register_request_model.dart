class RegisterRequestModel {
  RegisterRequestModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
    this.gender,
    this.height,
    this.weight,
    this.age,
    this.goal,
    this.activityLevel,
  });

  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? rePassword;
  String? gender;
  int? height;
  int? weight;
  int? age;
  String? goal;
  String? activityLevel;

  RegisterRequestModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    String? gender,
    int? height,
    int? weight,
    int? age,
    String? goal,
    String? activityLevel,
  }) {
    return RegisterRequestModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      age: age ?? this.age,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['password'] = password;
    map['rePassword'] = rePassword;
    map['gender'] = gender;
    map['height'] = height;
    map['weight'] = weight;
    map['age'] = age;
    map['goal'] = goal;
    map['activityLevel'] = activityLevel;
    return map;
  }
}
