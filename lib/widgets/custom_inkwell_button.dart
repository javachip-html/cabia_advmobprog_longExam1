import 'package:flutter/material.dart';

class CustomInkWellButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const CustomInkWellButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => InkWell(onTap: onTap, child: Padding(padding: const EdgeInsets.all(12), child: Text(label)));
}
