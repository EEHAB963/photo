import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photos/core/error/failures.dart';
import 'package:photos/core/error/streing/textError.dart';
import 'package:photos/core/size.dart';
import 'package:photos/ui/screens/search_screen.dart';
import 'package:photos/ui/widget/custom_grid_view.dart';
import 'package:photos/ui/widget/custom_no_internt_widget.dart';
import 'package:photos/ui/widget/loding_widget.dart';
import 'package:photos/ui/widget/up_scroll_widget.dart';

import '../../cubt/photo/all_photo/photo_cubit.dart';
import '../widget/custom_error_server_widget.dart';
import '../widget/custom_list_collction.dart';

class AllPhotoScreen extends StatefulWidget {
  AllPhotoScreen({super.key});

  @override
  State<AllPhotoScreen> createState() => _AllPhotoScreenState();
}

class _AllPhotoScreenState extends State<AllPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: bulidBody(context),
      ),
    );
  }

  bulidBody(BuildContext context) {
    return SingleChildScrollView(
      controller: BlocProvider.of<PhotoCubit>(context).controller,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MySize.customSize.gitSize(context, 15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(MySize.customSize.gitSize(context, 10)),
              child: Text(
                "Discover",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            //CustomListCategores(),
            BlocConsumer<PhotoCubit, PhotoState>(
              listener: (context, state) {
                if (state is InterntErrorState) {
                  scaffoldMessenger(context, state.error);
                } else if (state is ServerErrorState) {
                  scaffoldMessenger(context, state.error);
                }
              },
              builder: (context, state) {
                if (state is LodingState &&
                    BlocProvider.of<PhotoCubit>(context).allPhotos.isEmpty) {
                  return LoadingWidget();
                } else if (state is DoneState) {
                  return buildDoneStat();
                } else if (state is ServerErrorState &&
                    BlocProvider.of<PhotoCubit>(context).allPhotos.isEmpty) {
                  return const CustomErrorServerWidget();
                } else if (state is InterntErrorState &&
                    BlocProvider.of<PhotoCubit>(context).allPhotos.isEmpty) {
                  return CustomOffLineInterntWidget(
                    onTap: () {
                      BlocProvider.of<PhotoCubit>(context).allPhotos.clear();
                      BlocProvider.of<PhotoCubit>(context).pages.clear();
                      BlocProvider.of<PhotoCubit>(context).getAllPhoto(
                        page: 1,
                        per_page: 20,
                      );
                    },
                  );
                } else {
                  return buildDoneStat();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  buildDoneStat() {
    return CustomGridView(
      naxtPage:
          BlocProvider.of<PhotoCubit>(context).pages.last.next_page == null
              ? ""
              : BlocProvider.of<PhotoCubit>(context).pages.last.next_page!,
      photos: BlocProvider.of<PhotoCubit>(context).allPhotos.toList(),
      onTap: () {
        BlocProvider.of<PhotoCubit>(context).getDatawithScroll();
      },
      loding: BlocProvider.of<PhotoCubit>(context).loding,
    );
  }
}
