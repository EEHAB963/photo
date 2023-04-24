import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass/glass.dart';
import 'package:photos/cubt/photo/photo_categore/photo_categore_cubit.dart';
import 'package:photos/data/model/photos_modil/collection_modil.dart';

import 'custom_button.dart';

class CustomListCollciton extends StatelessWidget {
  const CustomListCollciton(
      {super.key,
      required this.collections,
      this.naxtPage,
      required this.onTap,
      required this.loding});
  final List<CollectionModil> collections;
  final String? naxtPage;
  final Function() onTap;
  final bool loding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          controller: BlocProvider.of<PhotoCategoreCubit>(context).controller,
          itemCount: collections.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            if (collections[index].photos_count == 0) {
              return const SizedBox();
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: collitonItem(index, context),
              );
            }
          },
        ),
        // The widget for the list breakdown
        naxtPage == ""
            ? const Icon(Icons.ac_unit)
            : CustomButtonSeeMore(onTap: onTap, loding: loding),
      ],
    );
  }

  Widget collitonItem(int index, BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                collections[index].title,
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                collections[index].photos_count.toString(),
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ).asGlass(
          tintColor: Colors.black,
          clipBorderRadius: BorderRadius.circular(30),
        ),
      ],
    );
  }
}
