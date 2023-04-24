part of 'open_photo_cubit.dart';

@immutable
abstract class OpenPhotoState {}

class OpenPhotoInitial extends OpenPhotoState {}
class LodingState extends OpenPhotoState {}
class DoneSaveState extends OpenPhotoState {}

class ServerErrorState extends OpenPhotoState {
  final String error;

  ServerErrorState(this.error);
}

class InterntErrorState extends OpenPhotoState {
  final String error;

  InterntErrorState(this.error);
}

class DoneState extends OpenPhotoState {
  final List<PhotoModil> data;
  DoneState(this.data);
}
