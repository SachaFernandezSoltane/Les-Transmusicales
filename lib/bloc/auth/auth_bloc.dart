import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart'; 
import 'auth_state.dart'; 
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        await Future.delayed(Duration(seconds: 2));

        if (event.username.isNotEmpty || event.password.isNotEmpty) {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.username,
            password: event.password,
          );
          emit(AuthAuthenticated(username: event.username));
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthFailure(message: e.code));
      }
    });
    on<AuthLogoutRequested>((event, emit) async {
      await FirebaseAuth.instance.signOut();
      emit(AuthLogout());
    });
  }
}
