abstract class MapsState {}

class MapsInitial extends MapsState {}

class MapsLoading extends MapsState {}

class MapsSuccess extends MapsState {
  final Map<String, Map<String, double>> mapsPoints;

  MapsSuccess({required this.mapsPoints});
}

class MapsMissing extends MapsState {}

class MapsFailure extends MapsState {
  final String message;

  MapsFailure({required this.message});
}
