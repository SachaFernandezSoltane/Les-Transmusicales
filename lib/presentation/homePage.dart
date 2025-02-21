import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tp_final/bloc/auth/auth_bloc.dart';
import 'package:tp_final/bloc/auth/auth_event.dart';
import 'package:tp_final/bloc/auth/auth_state.dart';
import 'package:tp_final/bloc/spotify_search/spotify_search_bloc.dart';
import 'package:tp_final/presentation/details_artist.dart';
import 'package:tp_final/presentation/login.dart';
import '../bloc/api/artiste/artiste_bloc.dart';
import '../bloc/api/artiste/artiste_state.dart';
import '../bloc/api/transmusicales/transm_bloc.dart';
import '../bloc/api/transmusicales/transm_state.dart';
import '../bloc/maps/maps_bloc.dart';
import '../bloc/maps/maps_event.dart';
import '../bloc/spotify_search/spotify_search_event.dart';
import '../modals/modal_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> scaleNotifier = ValueNotifier(1.0);

  List<bool> _isFavorite = [];

  @override
  void initState() {
    super.initState();
    // Initialiser _isFavorite avec une valeur par défaut
    _isFavorite = List.generate(
        10, (index) => false); // Ajustez la taille selon vos besoins
  }

  void toggleFavorite(int index) {
    setState(() {
      _isFavorite[index] = !_isFavorite[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowRightFromBracket,
                color: Theme.of(context).colorScheme.secondary, size: 25),
            onPressed: () {
              authBloc.add(AuthLogoutRequested());
            }),
        title: Row(
          children: [
            Spacer(),
            Center(
              child: Text(
                widget.title,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 28),
              ),
            ),
            Spacer(),
            ModalWidget(scaleNotifier: scaleNotifier),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLogout) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                }
              },
              child: Container(),
            ),
            BlocBuilder<ArtisteBloc, ArtisteState>(
              builder: (context, state) {
                if (state is ArtisteLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ArtisteLoaded) {
                  List<Map<String, String>> artistes = state.data;
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                              create: (context) =>
                                                  SpotifySearchBloc()
                                                    ..add(SpotifySearchRequested(
                                                        artistName: artiste[
                                                            "nomArtiste"]!))),
                                          BlocProvider(
                                              create: (context) => MapsBloc()
                                                ..add(MapsSearchPoints(
                                                    artistName: artiste[
                                                        "nomArtiste"]!))),
                                        ],
                                        child: DetailsArtistePage(
                                            artistName: artiste['nomArtiste']!,
                                            urlImage: artiste['urlImage']!),
                                      )));
                            },
                            child: Container(
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
                                    Image.network(
                                      artiste['urlImage']!,
                                      fit: BoxFit.cover,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.black
                                              .withValues(alpha: 0.5),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(25),
                                            bottomRight: Radius.circular(25),
                                          ),
                                        ),
                                        child: Text(
                                          artiste['nomArtiste']!,
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
                if (state is TransmLoaded) {
                  List<Map<String, dynamic>> transm = state.data;

                  if (_isFavorite.length != transm.length) {
                    _isFavorite =
                        List.generate(transm.length, (index) => false);
                  }
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: transm.length,
                        itemBuilder: (context, index) {
                          final random = Random();
                          final randomNumber = random.nextInt(8) + 1;
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                "assets/img/transmusicales/$randomNumber.jpg",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              transm[index]['nom'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            subtitle: Text(
                              transm[index]['date'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                _isFavorite[index]
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: _isFavorite[index]
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isFavorite[index] = !_isFavorite[index];
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else if (state is TransmFailure) {
                  return Center(child: Text('Erreur : ${state.message}'));
                }
                return const Center(child: Text('Aucun artiste trouvé.'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
