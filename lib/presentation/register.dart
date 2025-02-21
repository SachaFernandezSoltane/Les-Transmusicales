import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tp_final/bloc/auth/auth_bloc.dart';
import 'package:tp_final/bloc/auth/auth_event.dart';
import 'package:tp_final/bloc/auth/auth_state.dart';
import 'package:tp_final/bloc/sign_up/signup_bloc.dart';
import 'package:tp_final/bloc/sign_up/signup_event.dart';
import 'package:tp_final/bloc/sign_up/signup_state.dart';
import 'package:tp_final/presentation/homePage.dart';

import '../bloc/api/artiste/artiste_bloc.dart';
import '../bloc/api/artiste/artiste_event.dart';
import '../bloc/api/transmusicales/transm_bloc.dart';
import '../bloc/api/transmusicales/transm_event.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isButtonEnabled = false;

  void _checkFields() {
    setState(() {
      isButtonEnabled = _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final signUpBloc = context.read<SignupBloc>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A1A), Color(0xFF6A1B9A)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Rejoignez les Transmusicales",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Grunge',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Créez votre compte pour vivre l'expérience",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  controller: _usernameController,
                  onChanged: (_) => _checkFields(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    prefixIcon: Icon(Icons.email, color: Colors.white70),
                    hintText: "Votre email",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.purpleAccent, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.purpleAccent, width: 2),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  onChanged: (_) => _checkFields(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    prefixIcon: Icon(Icons.lock, color: Colors.white70),
                    hintText: "Mot de passe",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.purpleAccent, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.purpleAccent, width: 2),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  onChanged: (_) => _checkFields(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    prefixIcon: Icon(Icons.lock, color: Colors.white70),
                    hintText: "Confirmez le mot de passe",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.purpleAccent, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.purpleAccent, width: 2),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                BlocListener<SignupBloc, SignupState>(
                  listener: (context, state) {
                    if (state is SignUpAdded) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                      create: (context) =>
                                          ArtisteBloc()..add(ArtisteStarted())),
                                  BlocProvider(
                                      create: (context) =>
                                          TransmBloc()..add(TransmStarted())),
                                ],
                                child: HomePage(
                                  title: 'Home',
                                ),
                              )));
                    } else if (state is SignUpFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  child: BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      if (state is SignUpLoading) {
                        return Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: null,
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  backgroundColor: Colors.purpleAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 5,
                                  shadowColor:
                                      Colors.purpleAccent.withOpacity(0.5),
                                ),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isButtonEnabled
                                ? () {
                                    final username =
                                        _usernameController.text.trim();
                                    final password =
                                        _passwordController.text.trim();
                                    final confirmPassword =
                                        _confirmPasswordController.text.trim();
                                    if (password != confirmPassword) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Les mots de passe ne correspondent pas')),
                                      );
                                    } else {
                                      print('on arrive ici');
                                      signUpBloc.add(SignUpRequested(
                                          username: username,
                                          password: password));
                                    }
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Colors.purpleAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                              shadowColor: Colors.purpleAccent.withOpacity(0.5),
                            ),
                            child: Text(
                              "Créer un compte",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(FontAwesomeIcons.google,
                          color: Colors.white, size: 40),
                      onPressed: () {
                        // Connexion via Google
                      },
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.facebook,
                          color: Colors.white, size: 40),
                      onPressed: () {
                        // Connexion via Facebook
                      },
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.spotify,
                          color: Colors.white, size: 40),
                      onPressed: () {
                        // Connexion via Spotify
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Redirection vers la page de connexion
                  },
                  child: Text(
                    "Déjà un billet ? Connectez-vous",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
