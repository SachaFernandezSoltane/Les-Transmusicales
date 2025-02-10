import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tp_final/bloc/auth/auth_bloc.dart';
import 'package:tp_final/bloc/auth/auth_event.dart';
import 'package:tp_final/bloc/auth/auth_state.dart';
import 'package:tp_final/presentation/myHomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPressed = false;
  bool isButtonEnabled = false; // Variable pour gérer l'état du bouton

  void _togglePressedLogin() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  // Fonction pour vérifier si les deux champs sont remplis
  void _checkFields() {
    setState(() {
      isButtonEnabled = _usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
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
                  // Logo ou titre
                  Text(
                    "Transmusicales",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Grunge',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Plongez dans l'expérience musicale",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Champ Email
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

                  // Champ Mot de passe
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    onChanged: (_) => _checkFields(), 
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      prefixIcon: Icon(Icons.lock, color: Colors.white70),
                      hintText: "Votre mot de passe",
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

                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage(title: 'Home',)),
                      );
                      // if (state is AuthFailure) {
                      //   // Affiche une erreur
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(content: Text(state.message)),
                      //   );
                      // } 
                      // if(state is AuthAuthenticated){
                      //   Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //       builder: (context) => const MyHomePage(title: 'Home',)),
                      // );
                      // }
                    },
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
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
                              onPressed: isButtonEnabled ? () {
                                _togglePressedLogin();
                                final username = _usernameController.text.trim();
                                final password = _passwordController.text.trim();
                                if (username.isEmpty || password.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('One field is missing')),
                                  );
                                } else {
                                  BlocProvider.of<AuthBloc>(context).add(
                                    AuthLoginRequested(
                                        username: username, password: password),
                                  );
                                }
                              } : null, // Désactive le bouton si isButtonEnabled est false
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
                              child: Text(
                                "Entrez dans la fête",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 10),

                  // Lien "Mot de passe oublié"
                  TextButton(
                    onPressed: () {
                      // Action pour mot de passe oublié
                    },
                    child: Text(
                      "Mot de passe oublié ?",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Séparateur style égaliseur
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white70,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.graphic_eq, color: Colors.white70),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white70,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Boutons de réseaux sociaux
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

                  // Lien d'inscription
                  TextButton(
                    onPressed: () {
                      // Redirection vers la page d'inscription
                    },
                    child: Text(
                      "Pas encore de billet ? Rejoignez-nous",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
