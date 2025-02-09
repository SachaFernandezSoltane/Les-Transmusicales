import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tp_final/data/datasource/remote/api/data_api.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../modals/modal_fit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<String>> futureArtistes;

  @override
  void initState() {
    super.initState();
    futureArtistes = fetchArtistes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            IconButton(
              icon: Icon(FontAwesomeIcons.arrowRightFromBracket,
                  color: Colors.white, size: 25),
              onPressed: () {},
            ),
            Spacer(),
            Center(
              child: Text(widget.title),
            ),
            Spacer(),
            IconButton(
              icon: Icon(FontAwesomeIcons.circleUser,
                  color: Colors.white, size: 25),
              onPressed: () => showCupertinoModalBottomSheet(
                expand: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => ModalFit(),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: futureArtistes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun artiste trouvé.'));
          }

          List<String> artistes = snapshot.data!;

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
                  aspectRatio: 1 /
                      1.6, 
                  autoPlay: true,
                  enlargeCenterPage: false,
                  viewportFraction: 0.6,
                ),
                items: artistes.map((artiste) {
                  return Container(
                    width: 300.0,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          25),
                      color: Colors.grey[300],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          25),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            "assets/img/" + artiste + ".jpg",
                            fit: BoxFit.cover,
                          ),
                          
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double
                                  .infinity, 
                              padding: const EdgeInsets.all(
                                  10), 
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(
                                    0.5), 
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(
                                      25),
                                  bottomRight: Radius.circular(
                                      25),
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
              )
            ],
          );
        },
      ),
    );
  }
}
