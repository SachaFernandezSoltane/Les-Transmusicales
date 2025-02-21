abstract class MapsEvent {}

class MapsSearchPoints extends MapsEvent {
  final String artistName;

  MapsSearchPoints({required this.artistName});
}