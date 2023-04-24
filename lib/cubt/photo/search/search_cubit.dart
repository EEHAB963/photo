import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:photos/core/error/failures.dart';
import 'package:photos/core/error/streing/textError.dart';

import '../../../data/model/photos_modil/photo_modil.dart';
import '../../../data/model/photos_modil/photos_modil.dart';
import '../../../data/repositore/photo_repo/photo_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.photoRepo}) : super(SearchInitial());
  final PhotoRepo photoRepo;
  final Set<PhotoModil> allPhotos = {};
  final Set<PhotosModil> pages = {};
  ScrollController controller = ScrollController();
  TextEditingController categore = TextEditingController();
  bool loding = false;

  getAllPhotoWithCategore(
      {int? page, int? per_page, String? searchValue, String? naxtPage}) async {
    print("run bloc file with categore");

    emit(LodingState());
    loding = true;
    final photoAndError = await photoRepo.getSearchValeu(
        page: page,
        per_page: per_page,
        categore: searchValue,
        nextPage: naxtPage);
    photoAndError.fold((failur) {
      if (failur is ServerFailure) {
        return emit(ServerErrorState(SERVER_FAILURE));
      } else if (failur is NoDateFailure) {
        return emit(DataErrorState(NO_DATE_FAILURE));
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
    // ignore: avoid_single_cascade_in_expression_statements
    if (pages.last.next_page != null) {
      print("&&&&&&&&&&&&&&");
      print(pages.length);
      getAllPhotoWithCategore(naxtPage: pages.last.next_page);
    }
  }
}
