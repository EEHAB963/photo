import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photos/cubt/photo/photo_categore/photo_categore_cubit.dart';
import 'package:photos/cubt/photo/search/search_cubit.dart';
import 'package:photos/ui/screens/all_photo_screen.dart';
import 'package:photos/ui/screens/categore_screen.dart';
import 'package:photos/ui/screens/favorite_screen.dart';
import 'package:photos/ui/screens/search_screen.dart';

import '../../cubt/photo/all_photo/photo_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int conter = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          //backgroundColor: ,
          items: items,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.grey,
          elevation: 0,
          currentIndex: conter,
          onTap: (value) {
            int index = value;
            conter = index;
            setState(() {});
            if (value == 0) {
              BlocProvider.of<PhotoCubit>(context).controller.animateTo(1,
                  duration: const Duration(seconds: 2), curve: Curves.easeOut);
            } else if (value == 1) {
            } else if (value == 2 &&
                BlocProvider.of<SearchCubit>(context).pages.isNotEmpty) {
              BlocProvider.of<SearchCubit>(context).controller.animateTo(1,
                  duration: const Duration(seconds: 2), curve: Curves.easeOut);
            } else if (value == 3 &&
                BlocProvider.of<PhotoCategoreCubit>(context).pages.isNotEmpty &&
                BlocProvider.of<PhotoCategoreCubit>(context).controller.offset >
                    5) {
              BlocProvider.of<PhotoCategoreCubit>(context).controller.animateTo(
                  1,
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeOut);
            }
            ;
          },
        ),
        body: Screens[conter],
      ),
    );
  }

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
      label: "home",
    ),
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.bookmark),
      icon: Icon(Icons.bookmark_border),
      label: "favorite",
    ),
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.search),
      icon: Icon(Icons.search_outlined),
      label: "Search",
    ),
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.collections),
      icon: Icon(Icons.collections_sharp),
      label: "profile",
    ),
  ];

  List<Widget> Screens = [
    AllPhotoScreen(),
    const FavoritScreen(),
    SearchScreen(),
    CategoreScreen(),
  ];

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool exitApp = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white60,
          title: const Text("Realy ?"),
          content: const Text("Do you want to cloes the app ?"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text(
                  "NO",
                  style: TextStyle(color: Colors.redAccent),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Yes"))
          ],
        );
      },
    );
    return exitApp;
  }
}
