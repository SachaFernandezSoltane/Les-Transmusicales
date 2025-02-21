import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/spotify_search/spotify_search_bloc.dart';
import '../../bloc/spotify_search/spotify_search_state.dart';

class MusicWidget extends StatelessWidget {
  const MusicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpotifySearchBloc, SpotifySearchState>(
        builder: (context, state) {
      if (state is SpotifySearchLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is SpotifySearchSuccess) {
        return Column(
          children: state.albumList.map((album) {
            return ListTile(
              leading: Image.network(album['imgUrl'], width: 60, height: 60),
              title: Text(album['albumName'],
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary)),
              subtitle: Text(album['releaseDate']),
            );
          }).toList(),
        );
      } else {
        return const Center(child: Text('Aucun artiste trouvé.'));
      }
    });
  }
}
