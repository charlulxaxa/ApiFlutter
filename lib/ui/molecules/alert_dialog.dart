import 'package:flutter/material.dart';
import '../atoms/app_text.dart';
class CardDialog extends StatelessWidget {
  final String title;
  final Widget content;
  const CardDialog({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: AppText(title, style: AppTextStyle.name),
      content: SingleChildScrollView(child: content),
    );
  }
}