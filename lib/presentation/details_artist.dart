import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  ThemeMode _themeMode = ThemeMode.light;

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
          backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
          title: Center(
            child: Text(
              'Salvatore',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.8,
              floating: false,
              pinned: true,
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
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Description',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Musique n°#$index',
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        Text(
                          'Details $index',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 5,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300,
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(46.6033, 2.2110),
                      initialZoom: 5,
                    ),
                    children: [
                      TileLayer(
                        // Bring your own tiles
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
                        userAgentPackageName:
                            'com.example.app', // Add your app identifier
                        // And many more recommended properties!
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(48.0444, -1.7539),
                            width: 80,
                            height: 80,
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 20.0,
                            ),
                            
                          ),
                          Marker(
                            point: LatLng(48.1173, -1.6778),
                            width: 80,
                            height: 80,
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 20.0,
                            ),
                          )
                        ],
                      ),
                      RichAttributionWidget(
                        // Include a stylish prebuilt attribution widget that meets all requirments
                        attributions: [
                          TextSourceAttribution(
                            'OpenStreetMap contributors',
                            onTap: () => (Uri.parse(
                                'https://openstreetmap.org/copyright')), // (external)
                          ),
                          // Also add images...
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
