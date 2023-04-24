import 'package:flutter/material.dart';
import 'package:photos/core/size.dart';

class CustomCategore extends StatelessWidget {
  final String image;
  final String text;
  final Function() onTap;

  const CustomCategore(
      {super.key,
      required this.image,
      required this.text,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: MySize.customSize.gitSize(context, 80),
        width: MySize.customSize.gitSize(context, 100),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              MySize.customSize.gitSize(context, 20),
            ),
            image: DecorationImage(image: AssetImage(image), opacity: 1)),
        child: Container(
          alignment: Alignment.center,
          height: MySize.customSize.gitSize(context, 20),
          width: MySize.customSize.gitSize(context, 50),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(57, 39, 37, 37)
                  .withAlpha(200)
                  .withOpacity(.30)),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
