import 'package:flutter/material.dart';
import '../atoms/atoms.dart';
import '../molecules/molecules.dart';
import '../../models/yugiohModel.dart';

class YugiohCard extends StatelessWidget {
  final Yugioh yugioh;
  final VoidCallback? onAdd;

  const YugiohCard({super.key, required this.yugioh,this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (_) => CardDialog(
              title: yugioh.name,
              content: AppText(yugioh.desc, style: AppTextStyle.description),
            ),
          ),
          child: ImageWidget(imageUrl: yugioh.imageSmall),
        ),
        const SizedBox(height: 8),
        StatsBarWidget(
          name: yugioh.name,
          type: yugioh.type,
          atk: yugioh.atk,
          def: yugioh.def,
          level: yugioh.level,
          race: yugioh.race,
          attribute: yugioh.attribute,
        ),
        const SizedBox(height: 8),
        onAdd != null ? AppButton(label: 'Add Card', onPressed: onAdd): const SizedBox.shrink(),
      ],
    );
  }
}