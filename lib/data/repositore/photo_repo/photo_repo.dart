import 'package:dartz/dartz.dart';
import 'package:photos/core/network_info.dart';
import 'package:photos/data/data_sorcces/remot_data_sorcc.dart';
import 'package:photos/data/model/photos_modil/collections_modil.dart';
import 'package:photos/data/model/photos_modil/photos_modil.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failures.dart';

class PhotoRepo {
  final RemotDataSorcc remotDataSorcc;
  final NetworkInfo networkInfo;

  PhotoRepo({
    required this.remotDataSorcc,
    required this.networkInfo,
  });

  //Method for getting all photos without filters..
  Future<Either<Failur, PhotosModil>> getAllPhoto(
      { int? page,  int? per_page,String? nextPage}) async {
    print("run repo file");
    if (await networkInfo.iscommected) {
      try {
        final date =
            await remotDataSorcc.gitPhoto(page: page, per_page: per_page,nextPage: nextPage);
        return Right(date);
      } on ServerException {
        return Left(ServerFailure());
      } on NoDateException {
        return Left(NoDateFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  Future<Either<Failur, PhotosModil>> getSearchValeu(
      { int? page,
       int? per_page,
       String? categore,
       String? nextPage,
    
      String? color})async {
          print("run repo file");
    if (await networkInfo.iscommected) {
      try {
        final searchValue =
            await remotDataSorcc.getSearchValeu(page: page, per_page: per_page, categore: categore,color: color,nextPage: nextPage);
        return Right(searchValue);
      } on ServerException {
        return Left(ServerFailure());
      } on NoDateException {
        return Left(NoDateFailure());
      }
    } else {
      return Left(OfflineFailure());
    }


      }
      Future<Either<Failur, CollectionsModil>> getCollections({String? naxt_page})async{
       if (await networkInfo.iscommected) {
      try {
        final value =
            await remotDataSorcc.getCollections(nextPage: naxt_page);
        return Right(value);
      } on ServerException {
        return Left(ServerFailure());
      } on NoDateException {
        return Left(NoDateFailure());
      }
    } else {
      return Left(OfflineFailure());
    }


      }
       Future<Either<Failur, double>> download(String url)async{
         if (await networkInfo.iscommected){
          try{
            final value = await remotDataSorcc.download(url);
            return Right(value);

          }on ServerException {
        return Left(ServerFailure());
      }

         }else{
 return Left(OfflineFailure());
         }

       }


}
