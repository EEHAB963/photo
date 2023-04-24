import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:photos/core/network_info.dart';
import 'package:photos/cubt/photo/open_photo/open_photo_cubit.dart';
import 'package:photos/cubt/photo/photo_categore/photo_categore_cubit.dart';
import 'package:photos/ui/screens/home_screen.dart';
import 'core/theme/theme.dart';
import 'cubt/home_screen/home_screen_cubit.dart';
import 'cubt/photo/all_photo/photo_cubit.dart';
import 'cubt/photo/search/search_cubit.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await di.inti();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              di.ls<PhotoCubit>()..getAllPhoto(page: 1, per_page: 80),
        ),
        BlocProvider(
          create: (context) => di.ls<PhotoCategoreCubit>()..getAllCollctions(),
        ),
        BlocProvider(
          create: (context) => di.ls<OpenPhotoCubit>(),
        ),
        BlocProvider(
          create: (context) => di.ls<SearchCubit>(),
        ),
        BlocProvider(
          create: (context) => di.ls<HomeScreenCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        home: HomeScreen(),
      ),
    );
  }
}
