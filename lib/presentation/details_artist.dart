import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DetailsArtistePage extends StatefulWidget {
  const DetailsArtistePage({super.key});

  @override
  State<DetailsArtistePage> createState() => DetailsArtistePageState();
}

class DetailsArtistePageState extends State<DetailsArtistePage> {
  ThemeMode _themeMode = ThemeMode.light;
  bool _showList = true; // Gère l'affichage de la liste ou de la carte

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Center(
            child: Text(
              'Salvatore',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              floating: false,
              pinned: true,
              backgroundColor: Colors.black, // ✅ Fond noir ajouté
              flexibleSpace: Stack(
                fit: StackFit.expand,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 1.0,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      autoPlay: true,
                    ),
                    items: [
                      'assets/img/Salvatore.jpg',
                    ].map((path) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.asset(
                            path,
                            fit: BoxFit.cover,
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // 🔹 Ajout d'un espace après l'image
            SliverToBoxAdapter(
              child: Container(
                color: Colors.black, // ✅ Fond noir ajouté
                height: 20, // L'espace de 20px
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                color: Color.fromARGB(255, 0, 0, 0),
                height: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showList = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _showList ? Colors.blue : Colors.grey,
                        minimumSize: const Size(120, 50),
                      ),
                      child: const Text("Playlist",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showList = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !_showList ? Colors.blue : Colors.grey,
                        minimumSize: const Size(120, 50),
                      ),
                      child: const Text("Maps",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _showList ? _buildMusicList() : _buildMap(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMusicList() {
    return Column(
      children: List.generate(5, (index) {
        return Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              // Image carrée sur la gauche
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/img/Salvatore.jpg'), // Utilise ton image ici
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(
                      8.0), // Pour un rendu plus esthétique
                ),
              ),
              const SizedBox(width: 10), // Espace entre l'image et le texte
              // Colonne pour le titre et la date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Musique n°#$index', // Titre
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    const SizedBox(
                        height: 5), // Espace entre le titre et la date
                    Text(
                      'Date: 2025-02-16', // Date fictive
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // Icône de favoris à droite
              IconButton(
                onPressed: () {
                  // Logique pour ajouter aux favoris
                },
                icon: const Icon(Icons.favorite_border,
                    color: Colors.grey), // Icône de favoris
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildMap() {
    return SizedBox(
      height: 300,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(46.6033, 2.2110),
          initialZoom: 5,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(48.0444, -1.7539),
                width: 80,
                height: 80,
                child: const Icon(Icons.location_on,
                    color: Colors.red, size: 20.0),
              ),
              Marker(
                point: LatLng(48.1173, -1.6778),
                width: 80,
                height: 80,
                child: const Icon(Icons.location_on,
                    color: Colors.red, size: 20.0),
              )
            ],
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () => (Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
