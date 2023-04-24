part of 'photo_cubit.dart';

@immutable
abstract class PhotoState {}

class PhotoInitial extends PhotoState {}

class LodingState extends PhotoState {}

class ServerErrorState extends PhotoState {
  final String error;

  ServerErrorState(this.error);
}

class InterntErrorState extends PhotoState {
  final String error;

  InterntErrorState(this.error);
}

class DoneState extends PhotoState {
  final List<PhotoModil> data;
  DoneState(this.data);
}
