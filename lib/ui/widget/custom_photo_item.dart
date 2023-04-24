import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass/glass.dart';
import 'package:photos/core/size.dart';
import 'package:photos/cubt/photo/open_photo/open_photo_cubit.dart';
import 'package:photos/ui/screens/photo_open_screen.dart';

import '../../data/model/photos_modil/photo_modil.dart';
import 'custom_button_favoret.dart';

class CustomPhotoItem extends StatefulWidget {
  final PhotoModil photo;

  const CustomPhotoItem({super.key, required this.photo});

  @override
  State<CustomPhotoItem> createState() => _CustomPhotoItemState();
}

class _CustomPhotoItemState extends State<CustomPhotoItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 1, vertical: MySize.customSize.gitSize(context, 8)),
          child: Column(
            children: [
              Expanded(
                child: _image(widget.photo, context),
              ),
              const SizedBox(
                height: 4,
              ),
              photographerName(context),
            ],
          ),
        ),
         CustomButtomFavoret(photo:  widget.photo),
      ],
    );
  }

  Widget _image(PhotoModil photo, BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoOpenScreen(photo: photo),
            ));
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Image.network(
          photo.src.medium,
          loadingBuilder: (context, image, loadingProgress) {
            if (loadingProgress == null) return image;
            if (loadingProgress != null &&
                loadingProgress.cumulativeBytesLoaded <
                    loadingProgress.expectedTotalBytes!) {
              return Image.asset(
                "assets/images/logo.png",
                width: MySize.customSize.gitSize(context, 80),
              );
            } else if (loadingProgress.cumulativeBytesLoaded ==
                loadingProgress.expectedTotalBytes) {
              return image;
            }
            return image;
          },
          errorBuilder: (context, error, stackTrace) {
            return Center(
                child: Image.asset(
              "assets/images/sad.png",
              height: MySize.customSize.gitSize(context, 50),
              width: MySize.customSize.gitSize(context, 50),
            ));
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  photographerName(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
            radius: MySize.customSize.gitSize(context, 15),
            child: Text(widget.photo.photographer.substring(0, 1)),
            backgroundColor: hexToColor(widget.photo.avg_color)),
        SizedBox(
          width: MySize.customSize.gitSize(context, 10),
        ),
        SizedBox(
          width: MySize.customSize.gitSize(context, 120),
          child: Text(
            widget.photo.photographer,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
