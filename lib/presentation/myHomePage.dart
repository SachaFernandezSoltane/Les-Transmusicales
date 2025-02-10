import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../bloc/api/artiste/artiste_bloc.dart';
import '../bloc/api/artiste/artiste_event.dart';
import '../bloc/api/artiste/artiste_state.dart';
import '../bloc/api/transmusicales/transm_bloc.dart';
import '../bloc/api/transmusicales/transm_event.dart';
import '../bloc/api/transmusicales/transm_state.dart';
import '../modals/modal_fit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  ThemeMode _themeMode = ThemeMode.light;

  // Fonction pour basculer le thème
  void _toggleTheme() {
    setState(() {
      _themeMode =
          (_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Theme Demo',
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => ArtisteBloc()..add(ArtisteStarted())),
          BlocProvider(create: (context) => TransmBloc()..add(TransmStarted())),
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
            title: Row(
              children: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.arrowRightFromBracket,
                      color: Colors.white, size: 25),
                  onPressed: () {},
                ),
                Spacer(),
                Center(
                  child: Text(
                    widget.title,
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(FontAwesomeIcons.circleUser,
                      color: Colors.white, size: 25),
                  onPressed: () => showCupertinoModalBottomSheet(
                    expand: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => ModalFit(toggleTheme: _toggleTheme),
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                BlocBuilder<ArtisteBloc, ArtisteState>(
                  builder: (context, state) {
                    if (state is ArtisteLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ArtisteLoaded) {
                      List<String> artistes = state.data;

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  'Pour vous',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 300.0,
                              aspectRatio: 1 / 1.6,
                              autoPlay: true,
                              enlargeCenterPage: false,
                              viewportFraction: 0.6,
                            ),
                            items: artistes.map((artiste) {
                              return Container(
                                width: 300.0,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.grey[300],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.asset(
                                        "assets/img/$artiste.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(25),
                                              bottomRight: Radius.circular(25),
                                            ),
                                          ),
                                          child: Text(
                                            artiste,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      );
                    } else if (state is ArtisteFailure) {
                      return Center(child: Text('Erreur : ${state.message}'));
                    }

                    return const Center(child: Text('Aucun artiste trouvé.'));
                  },
                ),
                BlocBuilder<TransmBloc, TransmState>(
                  builder: (context, state) {
                    if (state is TransmLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TransmLoaded) {
                      List<String> artistes = state.data;

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  'Liste transmusicales',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: artistes.length,
                            itemBuilder: (context, index) {
                              final random = Random();
                              final randomNumber = random.nextInt(8) + 1;
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(15.0),
                                        ),
                                        child: Image.asset(
                                          "assets/img/transmusicales/"+ randomNumber.toString() +".jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        artistes[index],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    } else if (state is TransmFailure) {
                      return Center(child: Text('Erreur : ${state.message}'));
                    }

                    return const Center(
                        child: Text('Aucun artiste populaire trouvé.'));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
