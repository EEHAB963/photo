import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 36, fontWeight: FontWeight.w400, color: Colors.black),
      headline2: TextStyle(
          fontSize: 13, fontWeight: FontWeight.w900, color: Colors.black),
      subtitle1: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400),
    ),
  );
}
