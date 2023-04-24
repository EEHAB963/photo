import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    Key? key,
    required this.label,
    required this.keyboardType,
    required this.validator,
    required this.onFieldSubmitted,
    required this.controller,
  }) : super(key: key);
  final String label;
  //final Function() onSaved;
  final TextInputType keyboardType;
  String? Function(String?)? validator;
  final Function(String) onFieldSubmitted;
  final TextEditingController controller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
            fontFamily: "NunitoSans",
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          hintText: widget.label,
          prefixIcon: Icon(Icons.search)),
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
