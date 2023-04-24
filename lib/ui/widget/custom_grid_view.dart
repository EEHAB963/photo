import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:photos/core/error/streing/textError.dart';
import 'package:photos/core/network_info.dart';
import 'package:photos/core/size.dart';
import 'package:photos/data/model/photos_modil/photo_modil.dart';
import 'package:photos/ui/widget/custom_button.dart';
import 'package:photos/ui/widget/custom_photo_item.dart';

import '../../cubt/photo/all_photo/photo_cubit.dart';

class CustomGridView extends StatelessWidget {
  final List<PhotoModil> photos;
  final String? naxtPage;
  final Function() onTap;
  final bool loding;

  const CustomGridView({
    super.key,
    required this.photos,
    required this.naxtPage,
    required this.onTap,
    required this.loding,
  });

  @override
  Widget build(BuildContext context) {
    print("build grid view");
    if (photos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/sad.png",
              height: MySize.customSize.gitSize(context, 100),
            ),
            Text(NO_DATE_FAILURE),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          GridView.custom(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverWovenGridDelegate.count(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              pattern: [
                WovenGridTile(MySize.customSize.gitSize(context, 1) /
                    MySize.customSize.gitSize(context, 1.9)),
              ],
            ),
            childrenDelegate: SliverChildBuilderDelegate(
              childCount: photos.length,
              (context, index) => CustomPhotoItem(photo: photos[index]),
            ),
          ),
          // The widget for the list breakdown
          naxtPage == ""
              ? const Icon(Icons.ac_unit)
              : CustomButtonSeeMore(onTap: onTap, loding: loding),
        ],
      );
    }
  }
}
