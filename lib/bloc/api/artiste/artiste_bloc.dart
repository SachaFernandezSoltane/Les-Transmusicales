import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/datasource/remote/api/data_api.dart';
import 'artiste_event.dart';
import 'artiste_state.dart';

class ArtisteBloc extends Bloc<ArtisteEvent, ArtisteState> {
  ArtisteBloc() : super(ArtisteInitial()) {
    on<ArtisteStarted>((event, emit) async {
      emit(ArtisteLoading());

      try {
        final artistes = await fetchArtistes();
        emit(ArtisteLoaded(artistes));
      } catch (e) {
        emit(ArtisteFailure('Error: $e'));
      }
    });
  }
}
