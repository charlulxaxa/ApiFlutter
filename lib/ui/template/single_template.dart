import 'package:flutter/material.dart';

class SingleTemplate extends StatelessWidget {
  final PreferredSizeWidget appbar;
  final List<Widget> cards;

  const SingleTemplate({super.key, required this.appbar, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Column(
        children: [for (final c in cards) Expanded(child: c)],
      ),
    );
  }
}