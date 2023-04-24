part of 'photo_categore_cubit.dart';

@immutable
abstract class PhotoCategoreState {}

class PhotoCategoreInitial extends PhotoCategoreState {}
class LodingState extends PhotoCategoreState {}
class ServerErrorState extends PhotoCategoreState {
  final String error;

  ServerErrorState(this.error);
}

class InterntErrorState extends PhotoCategoreState {
  final String error;

  InterntErrorState(this.error);
}
class DataErrorState extends PhotoCategoreState {
  final String error;

  DataErrorState(this.error);
}
class DoneState extends PhotoCategoreState {
 }
