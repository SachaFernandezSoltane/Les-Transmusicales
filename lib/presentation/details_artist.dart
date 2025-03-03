import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tp_final/presentation/widget/map_widget.dart';
import 'package:tp_final/presentation/widget/music_widget.dart';
import '../modals/modal_widget.dart';
import 'widget/review_widget.dart';

class DetailsArtistePage extends StatefulWidget {
  const DetailsArtistePage(
      {super.key, required this.artistName, required this.urlImage});

  final String artistName;
  final String urlImage;

  @override
  State<DetailsArtistePage> createState() => DetailsArtistePageState();
}

class DetailsArtistePageState extends State<DetailsArtistePage> {
  final List<bool> _isFavorite = List.generate(5, (index) => false);
  final ValueNotifier<double> scaleNotifier = ValueNotifier(1.0);
  int _selectedTab = 0; // 0 = Playlist, 1 = Maps, 2 = Review

  void toggleFavorite(int index) {
    setState(() {
      _isFavorite[index] = !_isFavorite[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: scaleNotifier,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              leading: IconButton(
                icon: Icon(Icons.arrow_back,
                    color: Theme.of(context).colorScheme.secondary),
                onPressed: () => Navigator.pop(context),
              ),
              title: Row(
                children: [
                  if (widget.artistName.length > 20) ...[
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: Text(
                          widget.artistName,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    ModalWidget(scaleNotifier: scaleNotifier),
                  ] else ...[
                    Spacer(),
                    Center(
                      child: Text(
                        widget.artistName,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    Spacer(),
                    ModalWidget(scaleNotifier: scaleNotifier),
                  ],
                ],
              ),
            ),
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
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
                          widget.urlImage,
                        ].map((path) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Image.network(
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
                    color: const Color.fromARGB(255, 0, 0, 0),
                    height: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    color: Theme.of(context).colorScheme.tertiary,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedTab = 0;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _selectedTab == 0 ? Colors.blue : Colors.grey,
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text("Playlist",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                        ),
                        SizedBox(width: 10), // Espacement entre les boutons
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedTab = 1;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _selectedTab == 1 ? Colors.blue : Colors.grey,
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text("Maps",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                        ),
                        SizedBox(width: 10), // Espacement entre les boutons
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedTab = 2;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _selectedTab == 2 ? Colors.blue : Colors.grey,
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text("Review",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _selectedTab == 0
                      ? MusicWidget()
                      : _selectedTab == 1
                          ? MapWidget()
                          : ReviewWidget(
                              urlImage: widget.urlImage,
                            ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
