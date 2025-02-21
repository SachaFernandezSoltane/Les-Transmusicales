import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_final/bloc/spotify_search/spotify_search_event.dart';
import 'package:tp_final/bloc/spotify_search/spotify_search_state.dart';
import 'package:tp_final/data/datasource/remote/api/data_api.dart';

class SpotifySearchBloc extends Bloc<SpotifySearchRequested, SpotifySearchState> {
  SpotifySearchBloc() : super(SpotifySearchInitial()) {
    on<SpotifySearchRequested>((event, emit) async {
      emit(SpotifySearchLoading());

      try {
        final artistSpotify = await fetchAlbumArtist(event.artistName);
        emit(SpotifySearchSuccess(albumList: artistSpotify));
      } catch (e) {
        emit(SpotifySearchFailure(message: 'Error: $e'));
      }
    });
  }
}
