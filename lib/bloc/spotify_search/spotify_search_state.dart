// auth_state.dart
abstract class SpotifySearchState {}

class SpotifySearchInitial extends SpotifySearchState {}

class SpotifySearchLoading extends SpotifySearchState {}

class SpotifySearchSuccess extends SpotifySearchState {
  final List<Map<String, dynamic>> albumList;

  SpotifySearchSuccess({required this.albumList});
}

class SpotifySearchMissing extends SpotifySearchState {}

class SpotifySearchFailure extends SpotifySearchState {
  final String message;

  SpotifySearchFailure({required this.message});
}
