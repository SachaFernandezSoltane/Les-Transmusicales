import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/datasource/remote/api/data_api.dart';
import 'transm_event.dart';
import 'transm_state.dart';
class TransmBloc extends Bloc<TransmEvent, TransmState> {
  TransmBloc() : super(TransmInitial()) {
    on<TransmStarted>((event, emit) async {
      emit(TransmLoading());

      try {
        final Transms = await fetchTransms();
        emit(TransmLoaded(Transms));
      } catch (e) {
        emit(TransmFailure('Error: $e'));
      }
    });
  }
}
