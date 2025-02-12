import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
              style: TextStyle(
                  color: Colors.white), // Utilisez TextStyle pour le style
            ),
          ), // Utilisez un widget Text pour le titre
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
                      aspectRatio:
                          1.0, // Utilisez une valeur positive pour l'aspect ratio
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
                          'Item #$index',
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
                childCount: 20, // Nombre d'éléments dans la liste
              ),
            ),
          ],
        ),
      ),
    );
  }
}
