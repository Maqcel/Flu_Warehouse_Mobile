import 'package:equatable/equatable.dart';

class Login extends Equatable {
  const Login({
    required this.token,
    required this.name,
    required this.lastName,
    required this.jobTitle,
    required this.level,
  });

  final String token;
  final String name;
  final String lastName;
  final String jobTitle;
  final String level;

  @override
  List<Object> get props => [
        token,
        name,
        lastName,
        jobTitle,
        level,
      ];
}
