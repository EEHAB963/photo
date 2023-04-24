import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass/glass.dart';
import 'package:photos/data/model/photos_modil/photo_modil.dart';

import '../../core/size.dart';
import '../../cubt/photo/favoret/favoret_cubit.dart';

class CustomButtomFavoret extends StatefulWidget {
  CustomButtomFavoret({super.key, required this.photo});
  final PhotoModil photo;

  @override
  State<CustomButtomFavoret> createState() => _CustomButtomFavoretState();
}

class _CustomButtomFavoretState extends State<CustomButtomFavoret> {
  bool favorit = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MySize.customSize.gitSize(context, 20),
      right: MySize.customSize.gitSize(context, 10),
      child: InkWell(
        onTap: () async {
          if (favorit == false) {
            favorit = !favorit;
            setState(() {});
            BlocProvider.of<FavoretCubit>(context)
                .imageToBetys(widget.photo.src.original);
          } else {
            favorit = !favorit;
            setState(() {});
            BlocProvider.of<FavoretCubit>(context).notfavoret();
          }
        },
        child: Container(
                height: MySize.customSize.gitSize(context, 30),
                width: MySize.customSize.gitSize(context, 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                ),
                child: Icon(
                  favorit == false ? Icons.favorite_border : Icons.favorite,
                  color: favorit == false ? Colors.white : Colors.redAccent,
                ))
            .asGlass(
                tintColor: Colors.grey,
                clipBorderRadius: BorderRadius.circular(70)),
      ),
    );
  }
}
