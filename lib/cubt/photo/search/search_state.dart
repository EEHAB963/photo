part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}
class LodingState extends SearchState {}
class ServerErrorState extends SearchState {
  final String error;

  ServerErrorState(this.error);
}

class InterntErrorState extends SearchState {
  final String error;

  InterntErrorState(this.error);
}
class DataErrorState extends SearchState {
  final String error;

  DataErrorState(this.error);
}
class DoneState extends SearchState {
  final List <PhotoModil>  data;
DoneState(this.data);}
