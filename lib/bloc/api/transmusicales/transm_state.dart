abstract class TransmState {}

class TransmInitial extends TransmState {}

class TransmLoading extends TransmState {}

class TransmLoaded extends TransmState {
  final dynamic data;

  TransmLoaded(this.data);
}

class TransmFailure extends TransmState {
  final String message;

  TransmFailure(this.message);
}
