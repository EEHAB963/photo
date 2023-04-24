import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:photos/core/error/failures.dart';
import 'package:photos/data/model/photos_modil/photo_modil.dart';
import 'package:photos/data/model/photos_modil/photos_modil.dart';
import 'package:photos/data/repositore/photo_repo/photo_repo.dart';

import '../../../core/error/streing/textError.dart';

part 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  ScrollController controller = ScrollController();
  final PhotoRepo photoRepo;
  final Set<PhotoModil> allPhotos = {};
  final Set<PhotosModil> pages = {};
  bool viewButtonUp = false;
  bool loding = false;

  PhotoCubit({required this.photoRepo}) : super(PhotoInitial());
  getAllPhoto({ int? page,  int? per_page,String? nextPage}) async {
    print("run bloc file");

    emit(LodingState());
    loding = true;
    final photoAndError =
        await photoRepo.getAllPhoto(page: page, per_page: per_page,nextPage: nextPage);
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
      getAllPhoto(nextPage: pages.last.next_page
      );
    }
  }

  

  int page() {
    if (this.pages.last.page <= 800) {
      return pages.last.page + 1;
    } else {
      return 1;
    }
  }
}
