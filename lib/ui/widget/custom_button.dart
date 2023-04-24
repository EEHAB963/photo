
import 'package:flutter/material.dart';
import 'package:photos/core/size.dart';
import 'package:photos/ui/widget/loding_widget.dart';

class CustomButtonSeeMore extends StatelessWidget {
  const CustomButtonSeeMore(
      {super.key, required this.onTap, required this.loding});
  final Function() onTap;
  final bool loding;

  @override
  Widget build(BuildContext context) {
    if (loding == true) {
      return 
       LoadingWidget();
    } else {
      return InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.center,
          height: MySize.customSize.gitSize(context, 52),
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1),
                colors: <Color>[
                  Color(0xff1f005c),
                  Color(0xff5b0060),
                  Color(0xff870160),
                  Color(0xffac255e),
                  Color(0xffca485c),
                  Color(0xffe16b5c),
                  Color(0xfff39060),
                  Color(0xffffb56b),
                ],
                tileMode: TileMode.mirror,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black)),
          child: Text(
            "see more",
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: Colors.white),
          ),
        ),
      );
    }
  }
}
