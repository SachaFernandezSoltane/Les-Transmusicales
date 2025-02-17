import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_final/bloc/auth/auth_bloc.dart';
import 'package:tp_final/presentation/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white, // Couleur de fond pour le thème clair
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black, // Couleur de fond pour le thème sombre
      ),
      themeMode: ThemeMode.system,
      home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
                    create: (context) => AuthBloc(),
            ),

          ],
          child: LoginPage()
      ),
    );
  }
}

