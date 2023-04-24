import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:photos/cubt/home_screen/home_screen_cubit.dart';
import 'package:photos/cubt/photo/all_photo/photo_cubit.dart';
import 'package:photos/cubt/photo/open_photo/open_photo_cubit.dart';
import 'package:photos/cubt/photo/photo_categore/photo_categore_cubit.dart';
import 'package:photos/cubt/photo/search/search_cubit.dart';
import 'package:photos/data/repositore/photo_repo/photo_repo.dart';

import 'core/network_info.dart';
import 'data/data_sorcces/remot_data_sorcc.dart';

final ls = GetIt.instance;
Future<void> inti() async {
// bloc
  ls.registerFactory(() => PhotoCubit(photoRepo: ls()));
  ls.registerFactory(() => OpenPhotoCubit(photoRepo: ls()));
  ls.registerFactory(() => SearchCubit(photoRepo: ls()));
  ls.registerFactory(() => PhotoCategoreCubit(photoRepo: ls()));
  ls.registerFactory(() => HomeScreenCubit());

  // Replditory
  ls.registerLazySingleton(
      () => PhotoRepo(networkInfo: ls(), remotDataSorcc: ls()));

  // data Source
  ls.registerLazySingleton<RemotDataSorcc>(() => DataSorccWithDio());

  // core
  ls.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(ls()));

  // External
  ls.registerLazySingleton(() => InternetConnectionChecker());
}
