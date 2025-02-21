import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_final/bloc/maps/maps_event.dart';
import 'package:tp_final/bloc/maps/maps_state.dart';

import '../../data/datasource/remote/api/data_api.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  MapsBloc() : super(MapsInitial()) {
    on<MapsSearchPoints>((event, emit) async {
      emit(MapsInitial());

      try {
        final mapsPointsAPI = await fetchMapsPointsArtists(event.artistName);
        emit(MapsSuccess(mapsPoints: mapsPointsAPI));
      } catch (e) {
        emit(MapsFailure(message: e.toString()));
      }
    });
  }
}
