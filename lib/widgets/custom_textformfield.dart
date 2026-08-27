import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  const CustomTextFormField({super.key, required this.controller, required this.label, this.obscureText = false});

  @override
  Widget build(BuildContext context) => TextFormField(controller: controller, obscureText: obscureText, decoration: InputDecoration(labelText: label));
}
