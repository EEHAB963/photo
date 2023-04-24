import 'dart:math';

import 'package:flutter/material.dart';
import 'package:photos/core/size.dart';

class UpScroolWidget extends StatelessWidget {
  const UpScroolWidget({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: MySize.customSize.gitSize(context, 20),
      bottom: MySize.customSize.gitSize(context, 20),
      child: Container(
        height: MySize.customSize.gitSize(context, 50),
        width: MySize.customSize.gitSize(context, 50),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: const Alignment(0.8, 1),
              colors: <Color>[
                const Color(0xff1f005c).withOpacity(0.3),
                const Color(0xff5b0060).withOpacity(0.3),
                const Color(0xff870160).withOpacity(0.3),
                const Color(0xffac355e).withOpacity(0.3),
                const Color(0xffca485c).withOpacity(0.3),
                const Color(0xffe16b5c).withOpacity(0.3),
                const Color(0xfff39060).withOpacity(0.3),
                const Color(0xffffb56b).withOpacity(0.3),
              ],
              tileMode: TileMode.mirror,
            ),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white)),
        child: IconButton(
          icon: Icon(
            Icons.arrow_upward,
            size: MySize.customSize.gitSize(context, 25),
            color: Colors.white,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
