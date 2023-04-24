import 'package:flutter/material.dart';

import '../../core/size.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: MySize.customSize.gitSize(context, 200),
                  bottom: MySize.customSize.gitSize(context, 20)),
              child: const Icon(
                Icons.search,
                size: 100,
                color: Colors.grey,
              )),
          Text(
            "Type what you want to search for",
            style: Theme.of(context).textTheme.headline2,
          )
        ],
      ),
    );
  }
}
