import 'package:flutter/material.dart';

class CustomInfo extends StatelessWidget {
  final String label;
  final String value;
  const CustomInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) => ListTile(title: Text(label), subtitle: Text(value));
}
