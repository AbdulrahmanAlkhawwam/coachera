class RegisterParam {
  final RegisterStudentParam studentParam;
  final RegisterUserParam userParam;

  RegisterParam({
    required this.userParam,
    required this.studentParam,
  });
}

class RegisterUserParam {
  final String name;
  final String email;
  final String password;

  RegisterUserParam({
    required this.name,
    required this.email,
    required this.password,
  });
}

class RegisterStudentParam {
  final DateTime birthDate;
  final String education;
  final String firstName;
  final String gender;
  final String lastName;
  final String phoneNumber;
  final String address;

  RegisterStudentParam({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.address,
    required this.birthDate,
    required this.education,
    required this.phoneNumber,
  });
}
