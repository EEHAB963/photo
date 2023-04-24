import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'favoret_state.dart';

class FavoretCubit extends Cubit<FavoretState> {
  FavoretCubit() : super(FavoretInitial());

  imageToBetys(String url) async {
    Future<Uint8List?> loadImageByte(String url) async {
      Response<Uint8List> response = await Dio().get<Uint8List>(url,
          options: Options(responseType: ResponseType.bytes));
      return response.data;
    }

    print(loadImageByte);

   
  }

  notfavoret() {}
}
