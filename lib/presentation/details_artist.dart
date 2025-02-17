import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';

class DetailsArtistePage extends StatefulWidget {
  const DetailsArtistePage({super.key});

  @override
  State<DetailsArtistePage> createState() => DetailsArtistePageState();
}

class DetailsArtistePageState extends State<DetailsArtistePage> {
  final List<bool> _isFavorite = List.generate(5, (index) => false);

  void toggleFavorite(int index) {
    setState(() {
      _isFavorite[index] = !_isFavorite[index];
    });
  }

  bool _showList = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.secondary),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(children: [
            Spacer(),
            Center(
              child: Text(
                'Salvatore',
                style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 28),
              ),
            ),
            Spacer(),
            IconButton(
                icon: Icon(FontAwesomeIcons.circleUser,
                    color: Theme.of(context).colorScheme.secondary, size: 25),
                onPressed: () => Navigator.pop(context),
              ),
          ]),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              floating: false,
              pinned: true,
              backgroundColor: Colors.black,
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
                      'assets/img/artistes/Salvatore.jpg',
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
            SliverToBoxAdapter(
              child: Container(
                color: Colors.black,
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: const Color.fromARGB(255, 0, 0, 0),
                height: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 20,
                      decoration: const BoxDecoration(
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
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/img/artistes/Salvatore.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Musique n°#$index',
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Date: 2025-02-16',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  toggleFavorite(index);
                },
                icon: Icon(
                  _isFavorite[index] ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite[index] ? Colors.red : Colors.grey,
                ),
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
