import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.8, // 80% de la hauteur de l'écran
              floating: false,
              pinned: true,
              flexibleSpace: Stack(
                fit: StackFit.expand,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 0,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      autoPlay: true,
                    ),
                    items: [
                      'assets/img/Salvatore.jpg', // Remplacez par votre chemin d'image
                      // Ajoutez d'autres chemins d'images si nécessaire
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
                      color: Colors.black.withOpacity(0.5), // Semi-transparent
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
                            'Overview',
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
