import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:photos/core/error/streing/textError.dart';
import 'package:photos/data/model/photos_modil/collection_modil.dart';
import 'package:photos/data/model/photos_modil/collections_modil.dart';
import 'package:photos/data/repositore/photo_repo/photo_repo.dart';
import '../../../core/error/failures.dart';
import '../../../data/model/photos_modil/photo_modil.dart';
import '../../../data/model/photos_modil/photos_modil.dart';
part 'photo_categore_state.dart';

class PhotoCategoreCubit extends Cubit<PhotoCategoreState> {
  PhotoCategoreCubit({
    required this.photoRepo,
  }) : super(PhotoCategoreInitial());
  final PhotoRepo photoRepo;
  final Set<CollectionModil> allCollction = {};
  final Set<CollectionsModil> pages = {};
  ScrollController controller = ScrollController();
  bool loding = false;

  getAllCollctions({String? naxt_page}) async {
    print("run bloc file with categore");

    emit(LodingState());
    loding = true;
    final collctionsAndError = await photoRepo.getCollections(naxt_page: naxt_page);
    collctionsAndError.fold((failur) {
      if (failur is ServerFailure) {
        return emit(ServerErrorState(SERVER_FAILURE));
      } else if (failur is NoDateFailure) {
        return emit(DataErrorState(NO_DATE_FAILURE));
      } else {
        return emit(InterntErrorState(OFFLIN_FAILURE));
      }
    }, (data) {
      pages.add(data);
      allCollction.addAll(data.collections);
      loding = false;

      return emit(DoneState());
    });
  }

  getDatawithScroll({String? naxt_page}) {
    if (pages.last.next_page != null) {
      print("&&&&&&&&&&&&&&");
      print(pages.length);
      getAllCollctions(
         naxt_page:naxt_page );
    }
  }
}
