import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tp_final/bloc/sign_up/signup_event.dart';
import 'package:tp_final/bloc/sign_up/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignUpInitial()) {
    on<SignUpRequested>((event, emit) async {
      emit(SignUpLoading());

      try {
        await Future.delayed(Duration(seconds: 2));

        if (event.username.isNotEmpty || event.password.isNotEmpty) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.username,
            password: event.password,
          );
          emit(SignUpAdded(message: 'Added to database'));
        }
      } on FirebaseAuthException catch (e) {
        emit(SignUpFailure(message: e.code));
      }
    });
  }
}
