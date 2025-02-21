// auth_state.dart
abstract class SignupState {}

class SignUpInitial extends SignupState {}

class SignUpLoading extends SignupState {}

class SignUpAdded extends SignupState {
  final String message;

  SignUpAdded({required this.message});
}

class SignUpFailure extends SignupState {
  final String message;

  SignUpFailure({required this.message});
}
