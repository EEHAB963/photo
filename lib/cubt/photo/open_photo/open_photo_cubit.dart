// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../core/error/failures.dart';
import '../../../core/error/streing/textError.dart';
import '../../../data/model/photos_modil/photo_modil.dart';
import '../../../data/model/photos_modil/photos_modil.dart';
import '../../../data/repositore/photo_repo/photo_repo.dart';
import '../../../ui/widget/custom_no_internt_widget.dart';

part 'open_photo_state.dart';

class OpenPhotoCubit extends Cubit<OpenPhotoState> {
  OpenPhotoCubit({required this.photoRepo}) : super(OpenPhotoInitial());
  final PhotoRepo photoRepo;
  final Set<PhotoModil> allPhotos = {};
  final Set<PhotosModil> pages = {};
  bool loding = false;
  bool doneSave = false;
  InternetConnectionChecker connectionChecker = InternetConnectionChecker();

  getSpecificPhoto({
    int? page,
    int? per_page,
    String? categore,
    String? color,
    String? naxtPage,
  }) async {
    print("run bloc file with categore");

    emit(LodingState());
    loding = true;
    final photoAndError = await photoRepo.getSearchValeu(
        page: page,
        per_page: per_page,
        categore: categore,
        color: color,
        nextPage: naxtPage);
    photoAndError.fold((failur) {
      if (failur is ServerFailure) {
        return emit(ServerErrorState(SERVER_FAILURE));
      } else if (failur is NoDateFailure) {
      } else {
        return emit(InterntErrorState(OFFLIN_FAILURE));
      }
    }, (data) {
      pages.add(data);
      allPhotos.addAll(data.photos);
      loding = false;

      return emit(DoneState(allPhotos.toList()));
    });
  }

  getDatawithScroll() {
    if (pages.last.next_page != null) {
      getSpecificPhoto(naxtPage: pages.last.next_page);
    }
  }

  savePhoto(String url, BuildContext context) async {
    emit(LodingState());
    if (await connectionChecker.hasConnection) {
      var save = await GallerySaver.saveImage(
        url,
      );
      var d = await photoRepo.download(url);
      print(d);

      onProgress(double progres) {}
      if (save == true) {
        scaffoldMessenger(context, "Saved successfully",
            color: Colors.greenAccent);
        emit(DoneSaveState());
      } else {
        scaffoldMessenger(
          context,
          "Unable to save",
        );
        emit(DoneSaveState());
      }
    } else {
      scaffoldMessenger(
        context,
        OFFLIN_FAILURE,
      );
      emit(DoneSaveState());
    }
  }
}
