// auth_event.dart
abstract class SignupEvent {}

class SignUpStarted extends SignupEvent {}

class SignUpRequested extends SignupEvent {
  final String username;
  final String password;

  SignUpRequested({required this.username, required this.password});
}

