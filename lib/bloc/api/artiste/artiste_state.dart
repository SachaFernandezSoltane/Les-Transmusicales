abstract class ArtisteState {}

class ArtisteInitial extends ArtisteState {}

class ArtisteLoading extends ArtisteState {}

class ArtisteLoaded extends ArtisteState {
  final dynamic data;

  ArtisteLoaded(this.data);
}

class ArtisteFailure extends ArtisteState {
  final String message;

  ArtisteFailure(this.message);
}
