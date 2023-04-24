import 'package:flutter/material.dart';
import 'package:photos/core/size.dart';

import '../../core/error/streing/textError.dart';

scaffoldMessenger(BuildContext context, String error, {Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(error),
      backgroundColor: color == null ? Colors.red : color,
    ),
  );
}

class CustomOffLineInterntWidget extends StatelessWidget {
  final Function() onTap;

  const CustomOffLineInterntWidget({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/sad.png",
            height: MySize.customSize.gitSize(context, 100),
          ),
          Text(OFFLIN_FAILURE),
          IconButton(onPressed: onTap, icon: Icon(Icons.restart_alt))
        ],
      ),
    );
  }
}
