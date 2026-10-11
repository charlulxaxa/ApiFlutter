import 'package:flutter/material.dart';
import '../atoms/atoms.dart';

class BarApp extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? bgColor;

  const BarApp({super.key, required this.title, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AppText(title, style: AppTextStyle.title, color: Colors.white,),
      backgroundColor: bgColor ?? Colors.indigo,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}