import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tp_final/bloc/api/artiste/artiste_bloc.dart';
import 'package:tp_final/bloc/api/artiste/artiste_event.dart';
import 'package:tp_final/bloc/api/transmusicales/transm_bloc.dart';
import 'package:tp_final/bloc/api/transmusicales/transm_event.dart';
import 'package:tp_final/bloc/auth/auth_bloc.dart';
import 'package:tp_final/bloc/maps/maps_bloc.dart';
import 'package:tp_final/bloc/maps/maps_event.dart';
import 'package:tp_final/bloc/sign_up/signup_bloc.dart';
import 'package:tp_final/bloc/spotify_search/spotify_search_bloc.dart';
import 'package:tp_final/bloc/spotify_search/spotify_search_event.dart';
import 'package:tp_final/presentation/details_artist.dart';
import 'package:tp_final/presentation/login.dart';
import 'package:tp_final/presentation/homePage.dart';
import 'package:tp_final/theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(),
        ),
        // BlocProvider(create: (context) => ArtisteBloc()..add(ArtisteStarted())),
        // BlocProvider(create: (context) => TransmBloc()..add(TransmStarted())),
        // BlocProvider(
        //     create: (context) => SpotifySearchBloc()
        //       ..add(SpotifySearchRequested(artistName: 'Missill'))),
        // BlocProvider(
        //     create: (context) => MapsBloc()
        //       ..add(MapsSearchPoints(artistName: 'Missill'))),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Provider.of<ThemeProvider>(context).themeData,
            home: LoginPage(),
          );
        },
      ),
    );
  }
}
