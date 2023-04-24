import 'package:flutter/material.dart';

import '../../core/size.dart';

class CustomNoDataWidget extends StatelessWidget {
  const CustomNoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MySize.customSize.gitSize(context, 200),
                      bottom: MySize.customSize.gitSize(context, 20)),
                  child: Image.asset(
                    "assets/images/sad.png",
                    height: 100,
                  ),
                ),
                Text(
                  "Sorry, we did not find what you are looking for",
                  style: Theme.of(context).textTheme.headline2,
                )
              ],
            ),
          );
  }
}