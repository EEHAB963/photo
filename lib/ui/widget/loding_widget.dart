import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
   const LoadingWidget({Key? key,  this.color= Colors.redAccent}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: Colors.white.withOpacity(0.3),
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
